const fs = require("fs")

index = () => {
	return fs.readFileSync("./pages/index.html")
}

module.exports = index