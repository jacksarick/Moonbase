class HTTP_Server
	def initialize(port)
		@port = port
		@address = address
	end

	def start
		# Start the server
		print "server @ http://#{@address}:#{@port}\n"
		return TCPServer.new(@address, @port)
	end
end
