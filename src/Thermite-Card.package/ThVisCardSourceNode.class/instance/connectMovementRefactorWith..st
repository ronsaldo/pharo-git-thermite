testing
connectMovementRefactorWith: aNode
	| nextHead myTail |
	self allMovementRefactorNodesDo: [ :n | n == aNode ifTrue: [ ^ self ] ].

	nextHead := aNode firstMovementRefactorNode.
	myTail := self lastMovementRefactorNode.
	myTail nextMovementRefactorNode: nextHead.
	nextHead previousMovementRefactorNode: myTail.
	