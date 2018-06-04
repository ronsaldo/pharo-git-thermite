enumerating
union: anotherNode
	| leftRoot rightRoot |
	leftRoot := self findRootParent.
	rightRoot := anotherNode findRootParent.
	
	leftRoot == rightRoot ifTrue: [ ^ self ].
	
	leftRoot rank < rightRoot rank ifTrue: [
		leftRoot parent: rightRoot
	] ifFalse: [ 
		leftRoot rank > rightRoot rank ifTrue: [
			rightRoot parent: leftRoot
		] ifFalse: [
			rightRoot parent: leftRoot.
			leftRoot rank: leftRoot rank + 1
		]
	]