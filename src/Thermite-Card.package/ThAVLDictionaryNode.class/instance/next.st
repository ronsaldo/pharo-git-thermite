accessing
next
	| incoming position |
	right ifNotNil: [ ^ right farLeft ].
	incoming := self.
	position := parent.
	[ position ~~ nil ] whileTrue: [ 
		"Incoming from the left, the parent is the next"
		position left == incoming ifTrue: [
			^ position
		] ifFalse: [
			"Incoming from the right, keep moving up"
			incoming := position.
			position := position parent 
		]
	].

	^ nil