#!/usr/bin/env ruby

require "yaml"
require_relative '../utility.rb'
@config = read_YAML("config.yml")

# Grab arguments
project = ARGV[0]
projects = read_YAML(@config["database"])

# Remove info from database file
write_YAML @config["database"], projects.select { |e| e["project"] != project }

# Go to the project folder
Dir.chdir("#{@config['projects']}")

# Remove it with force
puts `rm -rf #{project}`