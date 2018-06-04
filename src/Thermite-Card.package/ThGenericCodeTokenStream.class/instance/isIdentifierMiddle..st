accessing
isIdentifierMiddle: aCharacter
	aCharacter ifNil: [ ^ false ].
	^ ($A <= aCharacter and: [ aCharacter <= $Z ]) or: [
		($a <= aCharacter and: [ aCharacter <= $z ]) or: [
		($0 <= aCharacter and: [ aCharacter <= $9 ]) or: [
		$_ = aCharacter]]]
