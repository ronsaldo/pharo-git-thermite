Class {
	#name : #ThCodeBagOfWords,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : 'Thermite-Card-CodeAnalysis-Similarity'
}

{ #category : #requirements }
ThCodeBagOfWords class >> empty [
	^ self new
]

{ #category : #'as yet unclassified' }
ThCodeBagOfWords class >> formForSimilaritiesOf: aCollection [
	^ self formForSimilaritiesOf: aCollection threshold: 0.0
]

{ #category : #'as yet unclassified' }
ThCodeBagOfWords class >> formForSimilaritiesOf: aCollection threshold: aThreshold [
	| form a b similarity gray color |
	form := Form extent: (aCollection size @ aCollection size) depth: 32.
	1 to: aCollection size do: [ :i |
		i to: aCollection size do: [ :j |
			a := aCollection at: i.
			b := aCollection at: j.
			similarity := a cosineSimilarityWith: b.
			gray := similarity asFloat min: 1.0.
			gray < aThreshold ifTrue: [ gray := 0.0 ].
			color := Color r: gray g: gray b: gray.
			form colorAt: (i @ j) put: color.
			form colorAt: (j @ i) put: color.
		]
	].
	^ form 
]

{ #category : #'as yet unclassified' }
ThCodeBagOfWords class >> matrixForSimilaritiesOf: aCollection [
	| matrix a b similarity |
	matrix := Matrix zeros: aCollection size.
	1 to: aCollection size do: [ :i |
		i to: aCollection size do: [ :j |
			a := aCollection at: i.
			b := aCollection at: j.
			similarity := a cosineSimilarityWith: b.
			matrix
				at: i at: j put: similarity;
				at: j at: i put: similarity
		]
	].
	^ matrix 
]

{ #category : #arithmetic }
ThCodeBagOfWords >> + other [
	| result |
	result := self class new.
	self with: other do: [ :i :a :b |
		result data at: i put: a + b
	].
	^ result

]

{ #category : #arithmetic }
ThCodeBagOfWords >> - other [
	| result |
	result := self class new.
	self with: other do: [ :i :a :b |
		result data at: i put: a - b
	].
	^ result

]

{ #category : #arithmetic }
ThCodeBagOfWords >> < other [
	self with: other do: [ :i :a :b |
		a < b ifTrue: [ ^ true ].
		a > b ifTrue: [ ^ false ].
	].
	^ false

]

{ #category : #comparing }
ThCodeBagOfWords >> = other [
	^ self class == other class and: [ data = other data ]
]

{ #category : #adding }
ThCodeBagOfWords >> add: anIndex [
	| node |
	node := data nodeAt: anIndex ifAbsentPut: [ 0 ].
	node value: node value + 1
]

{ #category : #arithmetic }
ThCodeBagOfWords >> cosineSimilarityWith: other [
	| result leftLength2 rightLength2 den |
	result := 0.
	leftLength2 := 0.
	rightLength2 := 0.	
	self with: other do: [ :i :a :b |
		leftLength2 := leftLength2 + (a*a).
		rightLength2 := rightLength2 + (b*b).	
		result := result + (a*b)
	].
	
	den := leftLength2 sqrt * rightLength2 sqrt.
	(den closeTo: 0) ifTrue: [ ^ 0 ].
	^ result / den
]

{ #category : #accessing }
ThCodeBagOfWords >> data [
	^ data
]

{ #category : #arithmetic }
ThCodeBagOfWords >> dot: other [
	| result |
	result := 0.
	self with: other do: [ :i :a :b |
		result := result + (a*b)
	].
	^ result

]

{ #category : #comparing }
ThCodeBagOfWords >> hash [
	^ self class identityHash bitXor: data hash
]

{ #category : #initialization }
ThCodeBagOfWords >> initialize [
	super initialize.
	data := ThAVLDictionary new.
	
]

{ #category : #arithmetic }
ThCodeBagOfWords >> length [
	^ self length2 sqrt
]

{ #category : #arithmetic }
ThCodeBagOfWords >> length2 [
	| result |
	result := 0.
	data valuesDo: [ :v | result := result + (v*v) ].
	^ result
]

{ #category : #printing }
ThCodeBagOfWords >> printOn: aStream [
	aStream nextPutAll: self class name; nextPutAll: ' data: '; print: data
]

{ #category : #arithmetic }
ThCodeBagOfWords >> with: other do: aBlock [
	| left right |
	left := self data begin.
	right := other data begin.
	
	[left isNotNil and: [ right isNotNil ]] whileTrue: [ 
		left key < right key ifTrue: [
			aBlock value: left key value: left value value: 0.
			left := left next
		] ifFalse: [
			right key < left key ifTrue: [ 
				aBlock value: right key value: 0 value: right value.
				right := right next
			] ifFalse: [
				aBlock value: left key value: left value value: right value.
				left := left next.
				right := right next
			]
		]
	].

	[ left isNotNil ]	whileTrue: [
		self assert: right isNil.
		aBlock value: left key value: left value value: 0.
		left := left next
	].

	[ right isNotNil ]	whileTrue: [ 
		self assert: left isNil.
		aBlock value: right key value: 0 value: right value.
		right := right next
	].

]
