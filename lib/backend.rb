require 'digest/md5'

require_relative './utility.rb'
require_relative './http-lib.rb'
require_relative './composer.rb'

def attempt_script_and_redirect(script, redirect)
	begin
		# scripts get run from start's level
		puts `#{script}`

		@socket.print http_redirect redirect
	rescue Exception => e
		puts e.message
		puts e.backtrace
		@socket.print http_redirect "/error.html"
	end
end

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
				attempt_script_and_redirect "./lib/scripting/new-project.rb #{data["user"]} #{data["repo"]}", "/dash"

			# Pull repo
			when "/pull"
				attempt_script_and_redirect "./lib/scripting/pull.rb #{data["project"]}", "/dash"

			# Delete repo
			when "/delete"
				attempt_script_and_redirect "./lib/scripting/remove.rb #{data["project"]}", "/dash"

			# Update repo
			when "/update"
				attempt_script_and_redirect "./lib/scripting/update.rb #{data["project"]} #{data["user"]} #{data["repo"]} #{data["desc"]} #{data["old"]}", "/dash"

			# Else it's probably a 404
			else
				@socket.print http_redirect "/error.html"
			end
		end
	end
end