require_relative './frontend.rb'

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
			socket.print "Only GET requests are supported right now"
			socket.close
		end
	end
end