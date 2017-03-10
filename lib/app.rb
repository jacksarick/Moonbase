require 'uri'

require_relative './frontend.rb'
require_relative './backend.rb'

def app(server)
	# Main loop that runs eternally
	loop do

		# Receive the request
		socket = server.accept
		
		# Try to handle request
		begin
			# Parse request
			request = socket.gets.split

			# Pull headers from request
			headers = {}
			while line = socket.gets.split(' ', 2)
				break if line[0] == "" 
				headers[line[0].chop] = line[1].strip 
			end

			# Parse relevent headers
			data = socket.read(headers["Content-Length"].to_i)
			# string -> array tuples (then decode them) -> flat array -> hash
			data = Hash[*data.split("&").map {
				|pair| pair.split("="). map { |item| URI.decode item }
			}.flatten] # For anyone curious, this is actually pretty neat

			# Sort by type
			if request[0] == 'GET'
				Frontend.new(socket).response(request)
			else
				Backend.new(socket).response(request, data)
			end

		# Throw generic failure
		rescue Exception => e
			puts e.message
			puts e.backtrace
			Frontend.new(socket).throw_error()
		end
	end
end