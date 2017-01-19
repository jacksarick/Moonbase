#!/usr/bin/env ruby

require "yaml"
require_relative '../utility.rb'
@config = read_YAML("config.yml")

project = ARGV[0]
projects = read_YAML(@config["database"])

write_YAML @config["database"], projects.select { |e| e["project"] != project }

Dir.chdir("#{@config['root']}/#{@config['projects']}")

puts `rm -rf #{project}`

Tutor