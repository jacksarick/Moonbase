require_relative './composer.rb'

class Frontend
	def initialize(socket)
		@socket = socket
	end

	def response(request)

		# Special index cases to route to index.html
		if ["/", "/dash", "/dashboard.html"].include? request[1]
			request[1] = '/index.html'
		end

		if request[1][0..2] == "/p/"
			request[1].gsub!("/p/", "/projects/")
			if request[-1] == "/"
				k += "index.html"
			end
		end

		# database = read_YAML(read_YAML("config.yml")["database"])
		@socket.print http_compose request[1]
	end
end