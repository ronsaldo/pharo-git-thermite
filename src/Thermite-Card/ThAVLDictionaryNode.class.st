Class {
	#name : #ThAVLDictionaryNode,
	#superclass : #Object,
	#instVars : [
		'parent',
		'left',
		'right',
		'height',
		'key',
		'value'
	],
	#category : 'Thermite-Card-CodeAnalysis-Similarity'
}

{ #category : #'as yet unclassified' }
ThAVLDictionaryNode >> balanceFactor [
	^ (self heightOfChild: right) - (self heightOfChild: left)
]

{ #category : #'as yet unclassified' }
ThAVLDictionaryNode >> child: child replacedWith: childReplacement [
	left == child ifTrue: [
		self left: childReplacement
	] ifFalse: [
		self assert: right == child.
		self right: childReplacement
	]
]

{ #category : #accessing }
ThAVLDictionaryNode >> children [
	(left isNil and: [ right isNil ]) ifTrue: [ ^ #() ].
	left ifNil: [ ^ { right } ].
	right ifNil: [ ^ { left } ].
	^ { left . right }
]

{ #category : #'as yet unclassified' }
ThAVLDictionaryNode >> farLeft [
	| position |
	position := self.
	[position left ~~ nil] whileTrue: [
		position := position left
	].
	^ position
]

{ #category : #'as yet unclassified' }
ThAVLDictionaryNode >> gtInspectorTree: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite tree 
		title: 'Tree';
		display: [ :d | self ];
		children: [ :each | each children ];
		format: [ :node | node printString ]
]

{ #category : #accessing }
ThAVLDictionaryNode >> height [
	^ height
]

{ #category : #accessing }
ThAVLDictionaryNode >> height: anObject [
	height := anObject
]

{ #category : #'as yet unclassified' }
ThAVLDictionaryNode >> heightOfChild: aChild [
	^ aChild ifNil: [ -1 ] ifNotNil: [ aChild height ]
]

{ #category : #initialization }
ThAVLDictionaryNode >> initialize [
	super initialize.
	height := 0.
]

{ #category : #accessing }
ThAVLDictionaryNode >> key [
	^ key
]

{ #category : #accessing }
ThAVLDictionaryNode >> key: anObject [
	key := anObject
]

{ #category : #accessing }
ThAVLDictionaryNode >> left [
	^ left
]

{ #category : #accessing }
ThAVLDictionaryNode >> left: anObject [
	left := anObject.
	left ifNotNil: [ left parent: self ]
]

{ #category : #accessing }
ThAVLDictionaryNode >> next [
	| incoming position |
	right ifNotNil: [ ^ right farLeft ].
	incoming := self.
	position := parent.
	[ position ~~ nil ] whileTrue: [ 
		"Incoming from the left, the parent is the next"
		position left == incoming ifTrue: [
			^ position
		] ifFalse: [
			"Incoming from the right, keep moving up"
			incoming := position.
			position := position parent 
		]
	].

	^ nil
]

{ #category : #accessing }
ThAVLDictionaryNode >> parent [
	^ parent
]

{ #category : #accessing }
ThAVLDictionaryNode >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
ThAVLDictionaryNode >> printOn: aStream [
	aStream print: key; nextPutAll: ' -> '; print: value
]

{ #category : #accessing }
ThAVLDictionaryNode >> right [
	^ right
]

{ #category : #accessing }
ThAVLDictionaryNode >> right: anObject [
	right := anObject.
	right ifNotNil: [ right parent: self ]
]

{ #category : #'private-geometry' }
ThAVLDictionaryNode >> updateHeight [
	height := ((self heightOfChild: left) max: (self heightOfChild: right)) + 1
]

{ #category : #accessing }
ThAVLDictionaryNode >> value [
	^ value
]

{ #category : #accessing }
ThAVLDictionaryNode >> value: anObject [
	value := anObject
]
