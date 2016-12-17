require_relative './composer.rb'

class Frontend
	def initialize(socket)
		@socket = socket
	end

	def response(request)
		# Special index case
		case request[1].split('').last
		when '/'
			@socket.print http_compose request[1] + 'index.html', read_config("projects.yml")
		else
			@socket.print http_compose request[1]
		end
	end
end