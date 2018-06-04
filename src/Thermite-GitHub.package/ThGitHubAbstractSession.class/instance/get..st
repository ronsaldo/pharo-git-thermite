resources
get: url
	| header headerParts contentSize content |
	self validSocketStream
		nextPutAll: 'get ' , url , String lf;
		flush.
	header := self validSocketStream upToAll: String lf.
	headerParts := header substrings.
	contentSize := headerParts third asInteger.
	content := self validSocketStream next: contentSize.
	self assert: self validSocketStream next = Character lf.

	^ ThGitHubExternalCacheResponse new
		code: headerParts first asInteger;
		message: headerParts second;
		content: content;
		yourself
	