tests
testForString
	| s a b |
	s := 'a b c'.
	a := builder forString: s.
	b := builder forString: s.
	self assert: a equals: b