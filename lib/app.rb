require './lib/composer.rb'

def app(server)
	# Main loop that runs eternally
	loop do

		# Receive the request
		socket = server.accept
		request = socket.gets.split

		print "#{request}\n"

		# Sort by type
		if request[0] == 'GET'
			# Special index case
			case request[1].split('').last
			when '/'
				socket.print http_compose request[1] + 'index.html', read_config("projects.yml")
			else
				socket.print http_compose request[1]
			end
		else
			socket.print "Only GET requests are supported right now"
			socket.close
		end
	end
end