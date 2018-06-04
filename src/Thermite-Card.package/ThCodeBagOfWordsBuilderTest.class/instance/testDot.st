tests
testDot
	| a b |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	self assert: (a dot: b) equals: 0.
	self assert: (a dot: a) equals: 3.
