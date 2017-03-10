# Class to generate HTTP servers
class Server
	# Set variables
	def initialize(address, port)
		@address = address
		@port = port
	end

	# Basic HTTP server
	def start
		# Start the server
		print "server @ http://#{@address}:#{@port}\n"
		return TCPServer.new(@address, @port)
	end
end
