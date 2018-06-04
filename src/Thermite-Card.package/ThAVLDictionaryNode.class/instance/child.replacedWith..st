as yet unclassified
child: child replacedWith: childReplacement
	left == child ifTrue: [
		self left: childReplacement
	] ifFalse: [
		self assert: right == child.
		self right: childReplacement
	]