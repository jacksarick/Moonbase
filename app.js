`use strict`

const http = require('http')
const port = 3000

const requestHandler = (request, response) => {  
	var req = request.url.split("/")[1]
	var [path, args] = req.split("#")

	// Converts / to /index.html
	path = path == ''? 'index.html' : path

	try {
		// Is it a great idea to hard code a header? No, no it is not
		response.setHeader("Content-Type", "text/html")
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