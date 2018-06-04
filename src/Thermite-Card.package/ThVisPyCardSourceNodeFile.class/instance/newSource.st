accessing
newSource
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource ]