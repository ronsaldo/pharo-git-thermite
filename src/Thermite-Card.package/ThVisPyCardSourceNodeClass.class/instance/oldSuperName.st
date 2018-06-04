accessing
oldSuperName
	^ oldModel ifNil: [ nil ] ifNotNil: [ oldModel superclassName ]