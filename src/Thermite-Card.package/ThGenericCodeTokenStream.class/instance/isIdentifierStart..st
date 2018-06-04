accessing
isIdentifierStart: aCharacter
	aCharacter ifNil: [ ^ false ].
	^ ($A <= aCharacter and: [ aCharacter <= $Z ]) or: [
		($a <= aCharacter and: [ aCharacter <= $z ]) or: [
		$_ = aCharacter]]
