public
getJson: url
	^ NeoJSONReader fromString: (self get: url) contents