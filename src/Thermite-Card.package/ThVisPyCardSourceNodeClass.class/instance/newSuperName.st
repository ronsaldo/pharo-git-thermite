accessing
newSuperName
	^ newModel ifNil: [ nil ] ifNotNil: [ newModel superclassName ]