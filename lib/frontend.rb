require_relative './composer.rb'
require_relative './utility.rb'

# Load config
config = read_YAML("config.yml")
DATABASE = read_YAML(config['database'])

# The class for handling the frontend
class Frontend

	# Set the variables on creation
	def initialize(socket)
		@socket = socket
	end

	# Route requests to destinations
	def response(request)
		# Pull the requested url
		url = request[1]

		data = []

		# Special index cases to route to index.html
		if ["/", "/dash", "/dashboard.html"].include? url
			url = '/index.html'
		end

		# Route to directory
		if url == "/dir"
			url = "/directory.html"
			data = DATABASE
		end

		# Projects have special routing rules
		if url[0..2] == "/p/"

			# Project specific root
			url.sub!(/\/p\/([^\/]+)\//) {|_|
				root = DATABASE.select { |p| p["repo"] == $1}.first['root']
				"/p/#{$1}/#{root}/" 
			}

			# Change first p -> projects
			url.sub!("/p/", "/projects/")

			# Index case
			if request[-1] == "/"
				url += "index.html"
			end
		end


		@socket.print http_compose url, data
	end

	# Simple error function
	def throw_error
		@socket.print http_compose "/bad-req.html"
	end
end