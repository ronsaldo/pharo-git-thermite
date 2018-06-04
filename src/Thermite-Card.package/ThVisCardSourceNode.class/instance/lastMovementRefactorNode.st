accessing
lastMovementRefactorNode
	nextMovementRefactorNode ifNil: [ ^ self ].
	^ nextMovementRefactorNode lastMovementRefactorNode