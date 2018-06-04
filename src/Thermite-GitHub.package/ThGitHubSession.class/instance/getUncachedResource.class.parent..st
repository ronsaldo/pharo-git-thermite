resources
getUncachedResource: url class: resourceClass parent: parent
	| response resource |
	response := self get: url.
	self updateRateLimits: response.
	resource := resourceClass new.
	self traceDownload: url.
	resource
		session: self;
		url: url;
		json: (NeoJSONReader fromString: response contents);
		etag: (response headers at: 'ETag');
		link: (response headers at: 'Link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource loaded.
	^ resource