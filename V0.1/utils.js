module.exports = {
	type: (content) => {
		content = content.split(".").slice(-1)[0]
		
		switch (content){
			case "css":
				return "text/css"
				break

			default:
				return "text/html"
		}
	}
}