accessing
tokenizer
	^ tokenizer ifNil: [ tokenizer := ThGenericCodeTokenStream new ]