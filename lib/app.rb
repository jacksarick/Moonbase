require 'uri'

require_relative './frontend.rb'
require_relative './backend.rb'

def app(server)
	# Main loop that runs eternally
	loop do

		# Receive the request
		socket = server.accept
		
		request = socket.gets.split

		headers = {}
		while line = socket.gets.split(' ', 2)
			break if line[0] == "" 
			headers[line[0].chop] = line[1].strip 
		end

		data = socket.read(headers["Content-Length"].to_i)
		# string -> array tuples (then decode them) -> flat array -> hash
		data = Hash[*data.split("&").map {
			|pair| pair.split("="). map { |item| URI.decode item }
		}.flatten]

		# Sort by type
		if request[0] == 'GET'
			Frontend.new(socket).response(request)
		else
			Backend.new(socket).response(request, data)
		end
	end
end