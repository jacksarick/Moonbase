class HTTP_Server
	def initialize(address, port)
		@address = address
		@port = port
	end

	def start
		# Start the server
		print "server @ http://#{@address}:#{@port}\n"
		return TCPServer.new(@address, @port)
	end
end
