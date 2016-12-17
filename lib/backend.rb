require 'digest/md5'

require_relative './composer.rb'

class Backend
	def initialize(socket)
		@socket = socket
		@password = File.open(read_YAML("config.yml")["user-key"]).read
	end

	def response(request, data)

		case request[1]
		when "/dash"


			puts Digest::MD5.hexdigest(data["password"]).length, @password.length
			if "#{Digest::MD5.hexdigest(data["password"])}" == "#{@password}"
				database = read_YAML(read_YAML("config.yml")["database"])
				@socket.print http_compose "/dashboard.html", database
			else
				@socket.print http_compose "/no-auth.html"
			end
			
		end
	end
end