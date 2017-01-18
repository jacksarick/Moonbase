#!/usr/bin/env ruby

require_relative '../utility.rb'
@config = read_YAML("config.yml")

project = ARGV[0]

Dir.chdir("#{@config['root']}/#{@config['projects']}/#{project}")

# puts `git remote show origin`
puts `git fetch origin && git reset --hard origin/master && ./setup`

puts "done"