#!/usr/bin/env ruby

projects = ARGV[0]
user = ARGV[1]
repo = ARGV[2]

# puts Dir.pwd

Dir.chdir("site/#{projects}")
exec "git clone https://github.com/#{user}/#{repo}.git"
puts "------------yeah------------\n"
Dir.chdir("#{repo}")
exec "./setup"
Dir.chdir("../..")