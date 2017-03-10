require 'yaml'

# I can never actually remeber the function
def read_YAML(file)
	return YAML.load_file(file)
end

# Function so it matches ^ that one
def write_YAML(file, data)
	File.open(file, "w+") do |f|
		f.write(data.to_yaml)
	end
end