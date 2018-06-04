accessing
isSpecial: aCharacter
	aCharacter ifNil: [ ^ false ].
	aCharacter <= Character space ifTrue: [ ^ false ].
	^ (self isIdentifierMiddle: aCharacter) not