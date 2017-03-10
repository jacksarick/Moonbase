#!/usr/bin/env ruby

require_relative '../utility.rb'
@config = read_YAML("config.yml")

# Grab arguments
user = ARGV[0]
repo = ARGV[1]

# Clone repo into projects
Dir.chdir("#{@config['projects']}")
puts `git clone --depth=1 https://github.com/#{user}/#{repo}.git`

# Set it up
Dir.chdir("#{repo}")

# Run setup if possible
if File.file?('./setup') == true
	begin
		puts `./setup`
	rescue Exception => e
		puts e.message
		puts e.backtrace
		puts "./setup failed"
	end
end

# Add it to projects
Dir.chdir("../../../user")
File.open("projects.yml", 'a') do |file|
	file.puts "- repo: #{repo}\n"
	file.puts "  project: #{repo}\n"
	file.puts "  user: #{user}\n"
	file.puts "  desc: (none yet!)"
	file.puts "  root: ''"
	file.puts ""
end
