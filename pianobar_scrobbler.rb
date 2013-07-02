#!/usr/bin/env ruby

# Installation:
#   1. Run 'bundle install'
#   2. Set the pianobar_scrobbler.rb file to be executable (755)
#   3. Rename pianobar_scrobbler_sample.yml to pianobar_scrobbler.yml then
#      update the lastfm username and password to match your credentials
#   4. Add the following line to pianobar's ~/.config/pianobar/config file:
#         event_command = /some/path/PianobarScrobbler/pianobar_scrobbler.rb
#   5. Restart pianobar
#
# gem: https://github.com/youpy/ruby-lastfm
# api: http://www.last.fm/api


require 'rubygems'
require 'lastfm'
require 'etc'


config = YAML.load(IO.read(File.join(File.dirname(__FILE__), "pianobar_scrobbler.yml")))


event = ARGV.first
data = {}
STDIN.each_line { |line| data.store(*line.chomp.split('=', 2)) }

fork do
  begin
    puts "---    fork start: #{"%-21s" % event} #{data['title']}" if config['log_level'] == 'debug'
  
    lastfm = Lastfm.new(config['api_key'], config['secret'])
    lastfm.session = lastfm.auth.get_mobile_session(:username => config['username'], :password => config['password'])['key']
  
    case event
      when 'songstart'
        # if no artist/title then query for it (like during a station switch)
        lastfm.track.update_now_playing(:artist => data['artist'], :track => data['title'])
      when 'songfinish'
        lastfm.track.scrobble(:artist => data['artist'], :track => data['title'])
      when 'songlove'
        lastfm.track.love(:artist => data['artist'], :track => data['title'])
  end
  rescue
    if config['log_level'] == 'debug'
      puts "=== #{$!.message} ===\n#{data.inspect}\n======"
      raise $!
    end
  ensure
    puts "--- fork complete: #{"%-21s" % event} #{data['title']}" if config['log_level'] == 'debug'
  end
end


#lastfm.track.love(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')

#lastfm.track.scrobble(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')

#lastfm.track.update_now_playing(:artist => 'Ooah', :track => 'Tuesday Again')
