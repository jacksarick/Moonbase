require_relative './composer.rb'

class Frontend
	def initialize(socket)
		@socket = socket
		@config = read_YAML("config.yml")

	end

	def response(request)
		# Special index case
		case request[1].split('').last
		when '/'
			@socket.print http_compose request[1] + 'index.html', read_YAML("./user/projects.yml")
		else
			@socket.print http_compose request[1]
		end
	end
end