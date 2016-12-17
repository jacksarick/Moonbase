#!/usr/bin/env ruby

require 'socket'
require './lib/app.rb'
require './lib/http-server.rb'

# Load config
config = read_config("config.yml")
PORT = config['port']

server = HTTP_Server.new(3000)
server = server.start()

app(server)