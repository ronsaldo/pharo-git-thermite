accessing
next
	| first |
	self skipWhite.
	in atEnd ifTrue: [ ^ nil ].
	
	first := in peek.
	(self isIdentifierStart: first) ifTrue: [ ^ self nextIdentifier ].
	(self isDigit: first) ifTrue: [ ^ self nextNumber ].
	^ self nextSpecial