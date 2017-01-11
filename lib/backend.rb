require 'digest/md5'

require_relative './utility.rb'
require_relative './http-lib.rb'
require_relative './composer.rb'

class Backend
	def initialize(socket)
		@socket = socket
		@config = read_YAML("config.yml")
		@password = File.open(@config["user-key"]).read
	end

	def authenticate(password)

		if password == "" or password == " "
			@socket.print http_redirect "/no-auth.html"
			return false

		elsif "#{Digest::MD5.hexdigest(password)}" == "#{@password}"
			return true

		else
			@socket.print http_redirect "/no-auth.html"
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
				puts `./lib/scripting/new-project.rb #{@config["projects"]} #{data["user"]} #{data["repo"]}`

				@socket.print http_redirect "/dash"

			end
		end
	end
end