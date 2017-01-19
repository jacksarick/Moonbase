#!/usr/bin/env ruby

require "yaml"
require_relative '../utility.rb'
@config = read_YAML("config.yml")project  = ARGV[0]
user 	 = ARGV[1]
repo 	 = ARGV[2]
desc 	 = ARGV[3]
old 	 = ARGV[4]

projects = read_YAML(@config["database"])
projects = projects.select { |e| e["project"] != old }
projects.push({'repo' => repo, 'project' => project, 'user' => user, 'desc' => desc})
write_YAML @config["database"], projects

Dir.chdir("#{@config['root']}/#{@config['projects']}")
puts `mv #{old} #{project}`