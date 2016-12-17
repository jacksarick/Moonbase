class HTTP_Server
	def initialize(port)
		@port = port
	end

	def start
		# Start the server
		print "server @ http://localhost:#{PORT}\n"
		return TCPServer.new('localhost', PORT)
	end
end