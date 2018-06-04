instance creation
forString: aString
	| t token index result |
	t := self tokenizer on: aString.
	result := ThCodeBagOfWords new.
	[ token := t next ] whileNotNil: [
		index := self indexForToken: token.
		result add: index
	].

	^ result