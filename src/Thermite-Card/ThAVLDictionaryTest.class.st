"
A GThAVLDictionaryTest is a test class for testing the behavior of GThAVLDictionary
"
Class {
	#name : #ThAVLDictionaryTest,
	#superclass : #TestCase,
	#category : #'Thermite-Card-Tests'
}

{ #category : #tests }
ThAVLDictionaryTest >> testEqual [
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
	self assert: b equals: a.
	self assert: a ~= c.
	self assert: b ~= c.
]

{ #category : #tests }
ThAVLDictionaryTest >> testHash [
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
]

{ #category : #tests }
ThAVLDictionaryTest >> testStress [
	| data dict values sorted |
	sorted := (1 to: 10000) collect: #yourself.
	data := sorted copy shuffleBy: (Random seed: 1).
	dict := ThAVLDictionary new.
	data do: [ :e | dict at: e put: e ].
	values := dict collect: #yourself.
	self assert: values equals: sorted
]
