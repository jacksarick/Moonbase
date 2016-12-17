require_relative './composer.rb'

class Frontend
	def initialize(socket)
		@socket = socket
	end

	def response(request)

		# Special index case
		if ["/", "/dashboard.html"].include? request[1]
			request[1] = '/index.html'
		end

		# print "###########################"
		# print request[1]
		# print "###########################"

		database = read_YAML(read_YAML("config.yml")["database"])
		@socket.print http_compose request[1], database
	end
end