#!/usr/bin/env ruby

require_relative '../utility.rb'
@config = read_YAML("config.yml")

user = ARGV[0]
repo = ARGV[1]

# puts Dir.pwd

# Clone repo into projects
Dir.chdir("#{@config['root']}/#{@config['projects']}")
puts `git clone --depth=1 https://github.com/#{user}/#{repo}.git`
puts `echo 'done'`

# Set it up
Dir.chdir("#{repo}")
puts `./setup`

# Add it to projects
Dir.chdir("../../../user")
File.open("projects.yml", 'a') do |file|
	file.puts ""
	file.puts "- project: #{repo}\n"
	file.puts "  user: #{user}\n"
	file.puts "  repo: #{repo}\n"
	file.puts "  repo: #{repo}\n"
	file.puts "  desc: (none yet!)"
end

puts "done"