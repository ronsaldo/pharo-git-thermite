accessing
nodeAt: aKey
	| position |
	position := root.
	[ position ] whileNotNil: [
		aKey = position key ifTrue: [ ^ position ].
		aKey < position key ifTrue: [
			position := position left
		] ifFalse: [ 
			position := position right
		]
	].
	^ nil