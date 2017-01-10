#!/usr/bin/env ruby

projects = ARGV[0]
user = ARGV[1]
repo = ARGV[2]

# puts Dir.pwd

Dir.chdir("site/#{projects}")
puts `git clone --depth=1 https://github.com/#{user}/#{repo}.git`
Dir.chdir("#{repo}")
puts `./setup`
Dir.chdir("../..")