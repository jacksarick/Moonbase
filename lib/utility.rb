require 'yaml'

def read_config(file)
	return YAML.load_file(file)
end