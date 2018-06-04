tests
testPlus
	| a b c |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	c := a + b.
	self assert: a ~= b.
	self assert: b ~= c.
	self assert: a equals: c.
