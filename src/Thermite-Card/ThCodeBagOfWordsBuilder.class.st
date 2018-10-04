Class {
	#name : #ThCodeBagOfWordsBuilder,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'tokenizer'
	],
	#category : 'Thermite-Card-CodeAnalysis-Similarity'
}

{ #category : #'instance creation' }
ThCodeBagOfWordsBuilder >> forString: aString [
	| t token index result |
	t := self tokenizer on: aString.
	result := ThCodeBagOfWords new.
	[ token := t next ] whileNotNil: [
		index := self indexForToken: token.
		result add: index
	].

	^ result
]

{ #category : #initialization }
ThCodeBagOfWordsBuilder >> indexForToken: aToken [
	^ dictionary at: aToken ifAbsentPut: [ dictionary size + 1 ]
]

{ #category : #initialization }
ThCodeBagOfWordsBuilder >> initialize [
	super initialize.
	dictionary := Dictionary new.
]

{ #category : #accessing }
ThCodeBagOfWordsBuilder >> tokenizer [
	^ tokenizer ifNil: [ tokenizer := ThGenericCodeTokenStream new ]
]

{ #category : #accessing }
ThCodeBagOfWordsBuilder >> tokenizer: anObject [
	tokenizer := anObject
]
