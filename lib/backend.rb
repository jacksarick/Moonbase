require 'digest/md5'

require_relative './composer.rb'

class Backend
	def initialize(socket)
		@socket = socket
		@config = read_YAML("config.yml")
		@password = File.open(@config["user-key"]).read
	end

	def authenticate(password)

		if password == "" or password == " "
			@socket.print http_compose "/no-auth.html"
			return false

		elsif "#{Digest::MD5.hexdigest(password)}" == "#{@password}"
			return true

		else
			@socket.print http_compose "/no-auth.html"
			return false
		end
	end

	def response(request, data)
		if authenticate(data["password"])
			case request[1]

			# Main dashboard
			when "/dash"
				database = read_YAML(@config["database"])
				@socket.print http_compose "/dashboard.html", database		
			
			# New record
			when "/new"
				# scripts get run from start's level
				puts exec "./lib/scripting/new-project.rb #{@config["projects"]} #{data["user"]} #{data["repo"]}"

				database = read_YAML(@config["database"])
				@socket.print http_compose "/dashboard.html", database		

			end
		end
	end
end