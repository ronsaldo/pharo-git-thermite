resources
getCachedResource: url class: resourceClass parent: parent
	| response responseContent resource |
	response := self get: url.
	responseContent := NeoJSONReader fromString: response content.
	
	resource := resourceClass new.
	resource
		session: self;
		url: url;
		json: (responseContent at: 'content');
		etag: (responseContent at: 'etag');
		link: (responseContent at: 'link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource loaded.
	^ resource
	