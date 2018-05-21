Class {
	#name : #ThVisUnionFindNode,
	#superclass : #Object,
	#instVars : [
		'value',
		'parent',
		'rank'
	],
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #'as yet unclassified' }
ThVisUnionFindNode >> findRootParent [
	parent ~~ self ifTrue: [ parent := parent findRootParent ].
	^ parent
]

{ #category : #initialization }
ThVisUnionFindNode >> initialize [
	super initialize.
	parent := self.
	rank := 0.
]

{ #category : #accessing }
ThVisUnionFindNode >> parent [
	^ parent
]

{ #category : #accessing }
ThVisUnionFindNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
ThVisUnionFindNode >> rank [
	^ rank
]

{ #category : #accessing }
ThVisUnionFindNode >> rank: anObject [
	rank := anObject
]

{ #category : #enumerating }
ThVisUnionFindNode >> union: anotherNode [
	| leftRoot rightRoot |
	leftRoot := self findRootParent.
	rightRoot := anotherNode findRootParent.
	
	leftRoot == rightRoot ifTrue: [ ^ self ].
	
	leftRoot rank < rightRoot rank ifTrue: [
		leftRoot parent: rightRoot
	] ifFalse: [ 
		leftRoot rank > rightRoot rank ifTrue: [
			rightRoot parent: leftRoot
		] ifFalse: [
			rightRoot parent: leftRoot.
			leftRoot rank: leftRoot rank + 1
		]
	]
]

{ #category : #accessing }
ThVisUnionFindNode >> value [
	^ value
]

{ #category : #accessing }
ThVisUnionFindNode >> value: anObject [
	value := anObject
]
