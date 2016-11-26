#!/usr/bin/env ruby

require 'socket'
require './utility.rb'

config = read_config("config.yml")
SERVER_ROOT = config['root']
PORT = config['port']

server = TCPServer.new('localhost', PORT)
print "server @ http://localhost:#{PORT}\n"

# The composition function that is really the magic of this whole operation
def compose(filename, replacements)
	# Read the file
	begin
		file = File.read(SERVER_ROOT + filename.strip)

		# Load includes
		file = file.gsub(/<<<([^>]+)>>>/) {|_| compose($1)}
		
		# Substitute replacements if dictionary included
		file = replacements != nil ? file.gsub(/\{\{\{([^\}]+)\}\}\}/) {|_| replacements[$1.strip]} : file

		return file

	rescue Exception => e
		print e.message
		return "Error 404: file " + filename + " not found"
	end
end

# Simple function for composing HTTP responses
def http_response(response, ending)
	return "HTTP/1.1 200 OK\r\n" +
		"Server: Custom (ruby)\r\n" +
		"Content-Type: text/#{ending}\r\n" +
		"Content-Length: #{response.bytesize}\r\n" +
		"Connection: close\r\n" +
		"\r\n" +
		response
end

# Compund function that mainly determines file type
def http_compose(filename, replace = nil)
	content = compose filename, replace

	type = filename.split('.').last

	case 
	when 'html', 'css'
		return http_response content, type
	when 'js'
		return http_response content, 'js'
	else
		return http_response content, 'plain'
	end
end

# Main loop that runs eternally
loop do

	socket = server.accept
	request = socket.gets.split

	print request
	print '\n'

	if request[0] == 'GET'
		case request[1]
		when '/'
			socket.print http_compose '/index.html'
		else
			socket.print http_compose request[1]
		end
	else
		socket.print "Only GET requests are supported right now"
		socket.close
	end
end