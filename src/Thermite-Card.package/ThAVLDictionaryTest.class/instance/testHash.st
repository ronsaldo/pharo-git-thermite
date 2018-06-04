tests
testHash
	| a b c |
	a := ThAVLDictionary new
		at: 1 put: 1;
		at: 2 put: 2;
		at: 3 put: 3;
		yourself.
	b := ThAVLDictionary new
		at: 3 put: 3;
		at: 1 put: 1;
		at: 2 put: 2;
		yourself.
	c := ThAVLDictionary new
		at: 1 put: 2;
		at: 2 put: 2;
		at: 3 put: 3;
		yourself.
	self assert: b hash equals: a hash