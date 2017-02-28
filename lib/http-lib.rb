@config = read_YAML("config.yml")

# Simple function for composing HTTP responses
def http_response(response, ending)
	return "HTTP/1.1 200 OK\r\n" +
		"Server: Custom (ruby)\r\n" +
		"Content-Type: text/#{ending}\r\n" +
		"Content-Length: #{response.bytesize}\r\n" +
		"Connection: close\r\n" +
		"\r\n" +
		response
end

# Redirect user to new link
def http_redirect(link)
	return "HTTP/1.1 303 See Other\r\n" +
		"Location: #{link}\r\n" +
		"\r\n" +
		"Redirecting...\r\n"
end
