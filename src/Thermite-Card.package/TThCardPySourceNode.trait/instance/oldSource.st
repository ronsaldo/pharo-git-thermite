accessing
oldSource
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource ]