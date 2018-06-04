instance creation
newSource
	^ self newModel ifNil: [ '' ] ifNotNil: #definitionSource