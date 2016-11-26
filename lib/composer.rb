require_relative './utility.rb'

# Load config
config = read_config("config.yml")
SERVER_ROOT = config['root']

def repeat_block(block, replacements)
	block.gsub! /\t|\n/, ''
	replacements.map { |vars|
		block.gsub(/\{\{\{([^\}]+)\}\}\}/) {|_|
			vars[$1.strip]
		}
	}.join
end

# The composition function that is really the magic of this whole operation
def compose(filename, replacements)
	# Read the file
	begin
		file = File.read(SERVER_ROOT + filename.strip)

		# Load includes
		file.gsub!(/<<<([^>]+)>>>/) {|_| compose $1}
		
		# Substitute replacements if dictionary included
		# file = replacements != nil ? file.gsub(/\{\{\{([^\}]+)\}\}\}/) {|_| replacements[$1.strip]} : file
		if replacements != nil
			file.gsub!(/\[\[\[([^\]]+)\]\]\]/) {|_| repeat_block $1, replacements}
		end

		return file

	# All errors, assume 404
	rescue Exception => e
		puts e.message
		puts e.backtrace
		return "Error 404: file " + filename + " not found"
	end
end

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

# Compund function that mainly determines file type
def http_compose(filename, replace = nil)
	content = compose filename, replace

	type = filename.split('.').last

	# Case the type, for now text only
	case 
	when 'html', 'css'
		return http_response content, type
	when 'js'
		return http_response content, 'js'
	else
		return http_response content, 'plain'
	end
end