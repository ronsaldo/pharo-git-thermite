tests
testCosineSimilarity
	| a b |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	self assert: ((a cosineSimilarityWith: b) closeTo: 0).
	self assert: ((a cosineSimilarityWith: a) closeTo: 1).
