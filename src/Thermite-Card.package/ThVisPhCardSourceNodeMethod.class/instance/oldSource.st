instance creation
oldSource
	^ self oldModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]