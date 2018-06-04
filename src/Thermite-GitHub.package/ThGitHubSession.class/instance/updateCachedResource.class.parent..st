resources
updateCachedResource: resource class: resourceClass parent: parent
	| client response |
	"Avoid immediate redownloading."
	(DateAndTime now - resource lastDownloadTime < RedownloadCacheTime) ifTrue: [
		^ resource
	].

	self traceDownload: resource url.
	client := self zincClient.
	client 
		url: resource url.
	client headerAt: 'If-None-Match' put: resource etag.
	response := client get; response.
	self updateRateLimits: response.
	response status = 304 ifTrue: [ ^ resource ].
	resource
		json: (NeoJSONReader fromString: response contents);
		etag: (response headers at: 'ETag');
		link: (response headers at: 'Link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource updated.
	^ resource