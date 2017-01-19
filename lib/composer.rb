require_relative './utility.rb'
require_relative './http-lib.rb'

# Load config
config = read_YAML("config.yml")
SERVER_ROOT = config['root']

# Repeat block {{{ ... }}} replacement function
def repeat_block(block, replacements)
	if replacements == false
		return ""
	end
	
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
		if replacements != false
			file.gsub!(/\[\[\[([^\]]+)\]\]\]/) {|_|
				repeat_block $1, replacements
			}
		else
			file.gsub!(/\[\[\[([^\]]+)\]\]\]/) {|_|
				""
			}
		end

		return file

	# All errors, assume 404
	rescue Exception => e
		puts e.message
		puts e.backtrace
		return "Error 404: file " + filename + " not found"
	end
end

# Compund function that mainly determines file type
def http_compose(filename, replace = nil)
	content = compose filename, replace

	type = filename.split('.').last

	# Case the type, for now text only
	case type
	when 'html', 'css'
		return http_response content, type
	when 'js'
		return http_response content, 'javascript'
	else
		return http_response content, 'plain'
	end
end