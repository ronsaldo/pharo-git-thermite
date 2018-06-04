accessing
shouldBeCountedAsMovement
	self isSimpleMovementRefactor ifFalse: [ ^ true ].
	parent hasMovementRefactor ifTrue: [ ^ false ].
	^ true