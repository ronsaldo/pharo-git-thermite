pagination
getLinkedPage: link
	link ifNil: [ ^ nil ].
	^ session getCachedResource: link arrayElementClass: elementClass