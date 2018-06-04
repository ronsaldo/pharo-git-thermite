tests
testForString2
	| a b c |
	a := builder forString: 'a b c'.
	b := builder forString: 'b d c'.
	c := builder forString: 'c b a'.
	self assert: a equals: c.
	self assert: a ~= b.
	self assert: b ~= c.