`use strict`

const http = require('http')
const port = 3000

const requestHandler = (request, response) => {  
	console.log(request.url)

	// Is it a great idea to hard code a header? No, no it is not
	response.setHeader("Content-Type", "text/html")
	response.setHeader("Server", "custom (node.js)")

	response.end(require("./pages.js")("./pages/index.html"))
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {  
	if (err) {
		return console.log('something bad happened', err)
	}

	console.log(`server is listening on ${port}`)
})