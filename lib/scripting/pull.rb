#!/usr/bin/env ruby

require_relative '../utility.rb'
@config = read_YAML("config.yml")

# Grab arguments
project = ARGV[0]

# Go to the project
Dir.chdir("#{@config['projects']}/#{project}")

# puts `git remote show origin`
puts `git fetch origin && git reset --hard origin/master && ./setup`

