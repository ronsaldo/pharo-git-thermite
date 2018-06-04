accessing
movementRefactorNodesDo: aBlock
	| position |
	position := self firstMovementRefactorNode.
	[ position ] whileNotNil: [
		position ~~ self ifTrue: [ 
			aBlock value: position.
		].
		position := position nextMovementRefactorNode
	]