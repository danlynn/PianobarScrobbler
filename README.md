# pianobar_scrobbler

pianobar_scrobbler updates your [last.fm](http://last.fm) account with
the [Pandora](http://pandora.com) tracks that you play using the 
[pianobar](http://6xq.net/projects/pianobar/) command-line Pandora client.
It updates the "now playing" status for each track when it starts.  Then 
when each track completes, it is added to the list of recently played 
tracks on last.fm.

## Requirements
1. Must have a pandora.com account: http://www.pandora.com
2. Must have a last.fm account: http://last.fm
3. Must have a last.fm api account: http://last.fm/api/accounts
4. pianobar is installed: http://6xq.net/projects/pianobar/
5. Ruby is installed: http://www.ruby-lang.org

## Installation

1. Run 'bundle install'
2. Set the pianobar_scrobbler.rb file to be executable (755)
3. Rename pianobar_scrobbler_sample.yml to pianobar_scrobbler.yml then
   update the lastfm username and password to match your credentials
4. Add the following line to pianobar's ~/.config/pianobar/config file:
      event_command = /some/path/PianobarScrobbler/pianobar_scrobbler.rb
5. Restart pianobar
