accessing
isDigit: aCharacter
	aCharacter ifNil: [ ^ false ].
	^ $0 <= aCharacter and: [ aCharacter <= $9 ]