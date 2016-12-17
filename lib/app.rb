require_relative './frontend.rb'
require_relative './backend.rb'

def app(server)
	# Backend.new()

	# Main loop that runs eternally
	loop do

		# Receive the request
		socket = server.accept
		request = socket.gets.split

		print "#{request}\n"

		# Sort by type
		if request[0] == 'GET'
			Frontend.new(socket).response(request)
		else
			Backend.new(socket).response(request)
		end
	end
end