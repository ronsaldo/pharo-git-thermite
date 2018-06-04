accessing
newLoc
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]