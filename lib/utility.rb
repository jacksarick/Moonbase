require 'yaml'

def read_YAML(file)
	return YAML.load_file(file)
end

def write_YAML(file, data)
	File.open(file, "w+") do |f|
		f.write(data.to_yaml)
	end
end