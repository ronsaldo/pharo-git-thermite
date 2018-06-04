resources
getCachedResource: url class: resourceClass parent: aParent
	^ urlCache at: url ifPresent: [:cachedResource |
		self updateCachedResource: cachedResource class: resourceClass parent: aParent
	] ifAbsentPut: [
		self getUncachedResource: url class: resourceClass parent: aParent
	]