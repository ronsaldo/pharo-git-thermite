accessing
oldLoc
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]