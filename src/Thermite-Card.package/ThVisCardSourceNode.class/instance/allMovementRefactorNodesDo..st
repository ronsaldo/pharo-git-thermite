accessing
allMovementRefactorNodesDo: aBlock
	| position |
	position := self firstMovementRefactorNode.
	[ position ] whileNotNil: [
		aBlock value: position.
		position := position nextMovementRefactorNode
	]