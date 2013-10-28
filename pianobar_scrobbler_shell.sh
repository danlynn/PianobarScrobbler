#!/bin/bash

source "$HOME/.rvm/scripts/rvm"

cd /Users/danlynn/Documents/Ruby/projects/PianobarScrobbler
bundle exec ./pianobar_scrobbler.rb $1 <&0
