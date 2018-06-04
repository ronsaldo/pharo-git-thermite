public
get: url
	^ self zincClient
		get: url;
		response