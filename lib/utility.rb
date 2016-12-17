require 'yaml'

def read_YAML(file)
	return YAML.load_file(file)
end