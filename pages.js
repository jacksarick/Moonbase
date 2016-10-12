const fs = require("fs")

read = (location) => {
	return fs.readFileSync(location)
}

// index = () => {
// 	return read("./pages/index.html")
// }

module.exports = read