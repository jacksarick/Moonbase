require_relative './composer.rb'

class Frontend
	def initialize(socket)
		@socket = socket
	end

	def response(request)

		case request[1]
		when "/auth"
			database = read_YAML(read_YAML("config.yml")["database"])
			@socket.print http_compose request[1], database
		end
	end
end