"
A GThCodeBagOfWordsBuilderTest is a test class for testing the behavior of GThCodeBagOfWordsBuilder
"
Class {
	#name : #ThCodeBagOfWordsBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : 'Thermite-Card-Tests'
}

{ #category : #initialization }
ThCodeBagOfWordsBuilderTest >> setUp [
	builder := ThCodeBagOfWordsBuilder new.
]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testCosineSimilarity [
	| a b |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	self assert: ((a cosineSimilarityWith: b) closeTo: 0).
	self assert: ((a cosineSimilarityWith: a) closeTo: 1).

]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testDot [
	| a b |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	self assert: (a dot: b) equals: 0.
	self assert: (a dot: a) equals: 3.

]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testForString [
	| s a b |
	s := 'a b c'.
	a := builder forString: s.
	b := builder forString: s.
	self assert: a equals: b
]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testForString2 [
	| a b c |
	a := builder forString: 'a b c'.
	b := builder forString: 'b d c'.
	c := builder forString: 'c b a'.
	self assert: a equals: c.
	self assert: a ~= b.
	self assert: b ~= c.
]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testPlus [
	| a b c |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	c := a + b.
	self assert: a ~= b.
	self assert: b ~= c.
	self assert: a equals: c.

]

{ #category : #tests }
ThCodeBagOfWordsBuilderTest >> testSubtract [
	| a b c |
	a := builder forString: 'a b c'.
	b := builder forString: ''.
	c := a - b.
	self assert: a ~= b.
	self assert: b ~= c.
	self assert: a equals: c.

]
