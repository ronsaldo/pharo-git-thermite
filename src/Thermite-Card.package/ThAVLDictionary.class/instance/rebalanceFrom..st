rotations
rebalanceFrom: insertedNode
	| child parent rotatedParent rotatedRoot balanceFactor nextParent nextChild |
	child := insertedNode.
	parent := insertedNode parent.
	[parent ~~ nil] whileTrue: [
		parent updateHeight.
		
		balanceFactor := parent balanceFactor.
			
		nextParent := parent parent.
		nextChild := parent.
			
		balanceFactor > 1 ifTrue: [ 
			rotatedParent := parent parent.
			child key > insertedNode key ifTrue: [
				rotatedRoot := self rotateRightLeftParent: parent child: child
			] ifFalse: [ 
				rotatedRoot := self rotateRightRightParent: parent child: child
			].

			rotatedParent ifNotNil: [ 
				rotatedParent child: parent replacedWith: rotatedRoot.
			] ifNil: [
				root := rotatedRoot.
				root parent: nil
			].
			
			nextParent := rotatedParent.
			nextChild := rotatedRoot.
		].

		balanceFactor < -1 ifTrue: [
			rotatedParent := parent parent.
			child key < insertedNode key ifTrue: [
				rotatedRoot := self rotateLeftRightParent: parent child: child
			] ifFalse: [
				rotatedRoot := self rotateLeftLeftParent: parent child: child
			].

			rotatedParent ifNotNil: [ 
				rotatedParent child: parent replacedWith: rotatedRoot.
			] ifNil: [
				root := rotatedRoot.
				root parent: nil
			].

			nextParent := rotatedParent.
			nextChild := rotatedRoot.
		].
		
		parent := nextParent.
		child := nextChild
	]