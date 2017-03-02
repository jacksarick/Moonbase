require 'socket'
require 'openssl'
require_relative './utility.rb'

# Load config
config = read_YAML("config.yml")

class Server
	def initialize(address, port)
		@address = address
		@port = port
	end

	def start
		# Make TCP socket (same as http)
		socket = TCPSocket.open(@address, @port)

		# Load up certs
		ssl_context = OpenSSL::SSL::SSLContext.new()
		ssl_context.cert = OpenSSL::X509::Certificate.new(File.open(config['cert']))
		ssl_context.key = OpenSSL::PKey::RSA.new(File.open(config['key']))
		ssl_context.ssl_version = :SSLv23

		# Send it off
		print "server @ https://#{@address}:#{@port}\n"
		return OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
	end
end