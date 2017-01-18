#!/usr/bin/env ruby

require_relative '../utility.rb'
@config = read_YAML("config.yml")

project = ARGV[0]

Dir.chdir("#{@config['root']}/#{@config['projects']}")

puts `rm -rf #{project}`

puts "done"