Class {
	#name : #ThAVLDictionary,
	#superclass : #Object,
	#instVars : [
		'root',
		'size'
	],
	#category : 'Thermite-Card-CodeAnalysis-Similarity'
}

{ #category : #comparing }
ThAVLDictionary >> = other [
	| left right |
	self class ~~ other class ifTrue: [ ^ false ].
	left := self begin.
	right := other begin.
	[ left isNil or: [right isNil] ] whileFalse: [ 
		(left key = right key and: [ left value = right value ]) ifFalse: [ ^ false ].
		left := left next.
		right := right next.
	].

	^ left isNil and: [right isNil]
]

{ #category : #accessing }
ThAVLDictionary >> at: aKey [
	| n |
	n := self nodeAt: aKey.
	n ifNil: [ self error: 'Key not found in the dictionary' ].
	^ n value
]

{ #category : #accessing }
ThAVLDictionary >> at: aKey put: aValue [
	| n |
	n := self nodeAt: aKey ifAbsentPut: [ nil ].
	n value: aValue.
	^ aValue
]

{ #category : #running }
ThAVLDictionary >> begin [
	root ifNil: [ ^ nil ].
	^ root farLeft
]

{ #category : #enumerating }
ThAVLDictionary >> collect: aBlock [
	| result destinationIndex |
	result := Array new: size.
	destinationIndex := 1.
	self valuesDo: [ :v |
		result at: destinationIndex put: (aBlock value: v).
		destinationIndex := destinationIndex + 1
	].
	^ result
]

{ #category : #enumerating }
ThAVLDictionary >> do: aBlock [
	| position |
	position := self begin.
	[ position ~~ nil ] whileTrue: [
		aBlock value: position.
		position := position next
	]
]

{ #category : #'as yet unclassified' }
ThAVLDictionary >> gtInspectorTree: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite tree 
		title: 'Tree';
		display: [ :d | root ];
		children: [ :each | each children ];
		format: [ :node | node printString ]
]

{ #category : #comparing }
ThAVLDictionary >> hash [
	| result position |
	result := self class identityHash.
	position := self begin.
	[ position isNotNil ] whileTrue: [ 
		result := result bitXor: position key hash.
		result := result bitXor: position value hash.
		position := position next
	].
	^ result
]

{ #category : #initialization }
ThAVLDictionary >> initialize [
	super initialize.
	size := 0.
]

{ #category : #accessing }
ThAVLDictionary >> nodeAt: aKey [
	| position |
	position := root.
	[ position ] whileNotNil: [
		aKey = position key ifTrue: [ ^ position ].
		aKey < position key ifTrue: [
			position := position left
		] ifFalse: [ 
			position := position right
		]
	].
	^ nil
]

{ #category : #accessing }
ThAVLDictionary >> nodeAt: aKey ifAbsentPut: aBlock [
	| position result |
	root ifNil: [
		size := size + 1.
		^ root := ThAVLDictionaryNode new
			key: aKey;
			value: aBlock value;
			yourself.
	].

	position := root.
	[
		position key = aKey ifTrue: [ ^ position ].
		aKey < position key ifTrue: [
			position left ifNil: [
				size := size + 1.
				result := ThAVLDictionaryNode new
					key: aKey;
					value: aBlock value;
					yourself.
				position left: result.
				self rebalanceFrom: result.
				^ result
			] ifNotNil: [
				position := position left
			]
		] ifFalse: [ 
			position right ifNil: [
				size := size + 1.
				result := ThAVLDictionaryNode new
					key: aKey;
					value: aBlock value;
					yourself.
				position right: result.
				self rebalanceFrom: result.
				^ result
			] ifNotNil: [
				position := position right
			]
		]
	] repeat
]

{ #category : #printing }
ThAVLDictionary >> printOn: aStream [
	aStream nextPutAll: self class name; nextPutAll: ' newFrom: {'; cr.
	self do: [ :node |
		aStream print: node key; nextPutAll: ' -> '; print: node value; nextPutAll: '.'; cr
	].
	aStream nextPutAll: '}'.
]

{ #category : #rotations }
ThAVLDictionary >> rebalanceFrom: insertedNode [
	| child parent rotatedParent rotatedRoot balanceFactor nextParent nextChild |
	child := insertedNode.
	parent := insertedNode parent.
	[parent ~~ nil] whileTrue: [
		parent updateHeight.
		
		balanceFactor := parent balanceFactor.
			
		nextParent := parent parent.
		nextChild := parent.
			
		balanceFactor > 1 ifTrue: [ 
			rotatedParent := parent parent.
			child key > insertedNode key ifTrue: [
				rotatedRoot := self rotateRightLeftParent: parent child: child
			] ifFalse: [ 
				rotatedRoot := self rotateRightRightParent: parent child: child
			].

			rotatedParent ifNotNil: [ 
				rotatedParent child: parent replacedWith: rotatedRoot.
			] ifNil: [
				root := rotatedRoot.
				root parent: nil
			].
			
			nextParent := rotatedParent.
			nextChild := rotatedRoot.
		].

		balanceFactor < -1 ifTrue: [
			rotatedParent := parent parent.
			child key < insertedNode key ifTrue: [
				rotatedRoot := self rotateLeftRightParent: parent child: child
			] ifFalse: [
				rotatedRoot := self rotateLeftLeftParent: parent child: child
			].

			rotatedParent ifNotNil: [ 
				rotatedParent child: parent replacedWith: rotatedRoot.
			] ifNil: [
				root := rotatedRoot.
				root parent: nil
			].

			nextParent := rotatedParent.
			nextChild := rotatedRoot.
		].
		
		parent := nextParent.
		child := nextChild
	]
]

{ #category : #rotations }
ThAVLDictionary >> rotateLeftLeftParent: parent child: child [

	| top left right first second third fourth |
	top := child.
	left := child left.
	right := parent.
	
	first := child left left.
	second := child left right.
	third := child right.
	fourth := parent right.
	
	top left: left.
	top right: right.

	left left: first.
	left right: second.
	right left: third.
	right right: fourth.
		
	left updateHeight.
	right updateHeight.
	top updateHeight.
	^ top
]

{ #category : #rotations }
ThAVLDictionary >> rotateLeftRightParent: parent child: child [

	| top left right first second third fourth |
	top := child right.
	left := child.
	right := parent.
	
	first := child left.
	second := child right left.
	third := child right right.
	fourth := parent right.
	
	top left: left.
	top right: right.

	left left: first.
	left right: second.
	right left: third.
	right right: fourth.
		
	left updateHeight.
	right updateHeight.
	top updateHeight.
	^ top
]

{ #category : #rotations }
ThAVLDictionary >> rotateRightLeftParent: parent child: child [

	| top left right first second third fourth |
	top := child left.
	left := parent.
	right := child.
	
	first := parent left.
	second := child left left.
	third := child left right.
	fourth := child right.
	
	top left: left.
	top right: right.

	left left: first.
	left right: second.
	right left: third.
	right right: fourth.
	
	left updateHeight.
	right updateHeight.
	top updateHeight.
	^ top
]

{ #category : #rotations }
ThAVLDictionary >> rotateRightRightParent: parent child: child [

	| top left right first second third fourth |
	top := child.
	left := parent.
	right := child right.
	
	first := parent left.
	second := child left.
	third := child right left.
	fourth := child right right.
	
	top left: left.
	top right: right.

	left left: first.
	left right: second.
	right left: third.
	right right: fourth.
	
	left updateHeight.
	right updateHeight.
	top updateHeight.
	^ top
]

{ #category : #accessing }
ThAVLDictionary >> size [
	^ size
]

{ #category : #enumerating }
ThAVLDictionary >> valuesDo: aBlock [
	^ self do: [ :n | aBlock value: n value ]
]
