`use strict`

const util = require('./utils.js')
const http = require('http')
const port = 3000

const requestHandler = (request, response) => {  
	var req = request.url.split("/")[1]
	var [path, args] = req.split("#")

	// Converts / to /index.html
	path = path == ''? 'index.site' : path

	try {
		response.setHeader("Content-Type", util.type(path))
		response.setHeader("Server", "custom (node.js)")

		response.end(require("./pages.js")("./pages/" + path))
	}

	catch (err) {
		response.statusCode = 404
		response.end([] + err) //HAHAHA WHAT?!?!?
	}
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {  
	if (err) {
		return console.log('something bad happened', err)
	}

	console.log(`server is listening at http://localhost:${port}`)
})