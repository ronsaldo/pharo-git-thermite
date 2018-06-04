instance creation
newSource
	^ self newModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]