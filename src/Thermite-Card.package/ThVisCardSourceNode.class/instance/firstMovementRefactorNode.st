accessing
firstMovementRefactorNode
	previousMovementRefactorNode ifNil: [ ^ self ].
	^ previousMovementRefactorNode firstMovementRefactorNode