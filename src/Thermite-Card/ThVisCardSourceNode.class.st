Class {
	#name : #ThVisCardSourceNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'parent',
		'children',
		'oldModel',
		'newModel',
		'wasModified',
		'diff',
		'additions',
		'deletions',
		'unchangedNumberOfLines',
		'oldSourceBagOfWords',
		'newSourceBagOfWords',
		'sourceBagOfWords',
		'hasMovementRefactor',
		'previousMovementRefactorNode',
		'nextMovementRefactorNode',
		'palette'
	],
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #accessing }
ThVisCardSourceNode >> additions [
	additions ifNil: [ self computeDiffStats ].
	^ additions
]

{ #category : #enumerating }
ThVisCardSourceNode >> allChildrenDo: aBlock [
	children do: [:child |
		aBlock value: child.
		child allChildrenDo: aBlock
	]
]

{ #category : #accessing }
ThVisCardSourceNode >> allMovementRefactorNodesDo: aBlock [
	| position |
	position := self firstMovementRefactorNode.
	[ position ] whileNotNil: [
		aBlock value: position.
		position := position nextMovementRefactorNode
	]
]

{ #category : #accessing }
ThVisCardSourceNode >> allNewSource [
	^ self newSource
]

{ #category : #accessing }
ThVisCardSourceNode >> allOldSource [
	^ self oldSource
]

{ #category : #visualization }
ThVisCardSourceNode >> changeBorderColor [
	self wasAdded ifTrue: [ ^ self palette additionsColor ].
	self wasRemoved ifTrue: [ ^ self palette deletionsColor ].
	^ self wasModified ifTrue: [ self palette modifiedColor ] ifFalse: [ self palette normalNodeBorderColor ]
]

{ #category : #visualization }
ThVisCardSourceNode >> changeColor [
	self wasAdded ifTrue: [ ^ self palette additionsColor ].
	self wasRemoved ifTrue: [ ^ self palette deletionsColor ].
	^ self wasModified ifTrue: [ self palette nodeModifiedColor ] ifFalse: [ self palette unchangedColor ]
]

{ #category : #testing }
ThVisCardSourceNode >> checkForChildModification [
	children valuesDo: [ :child | child wasModified ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ThVisCardSourceNode >> checkForModification [
	^ self oldSource trimBoth ~= self newSource trimBoth or: [ self checkForChildModification ]
]

{ #category : #accessing }
ThVisCardSourceNode >> childNamed: childName ifAbsentPut: aBlock [ 
	^ children at: childName ifAbsent: [
		| result |
		result := aBlock value.
		result parent: self.
		children at: result name put: result.
		result 
	]
]

{ #category : #accessing }
ThVisCardSourceNode >> childPrefix: prefix named: childName ifAbsentPut: aBlock [ 
	^ children at: prefix , childName ifAbsent: [
		| result |
		result := aBlock value.
		result parent: self.
		children at: prefix , result name put: result.
		result 
	]
]

{ #category : #accessing }
ThVisCardSourceNode >> children [
	^ children values
]

{ #category : #accessing }
ThVisCardSourceNode >> computeDiffStats [
	| diffBuilder |
	unchangedNumberOfLines := 0.
	additions := 0.
	deletions := 0.
	diffBuilder := TextDiffBuilder from: self oldSource to: self newSource.
	diffBuilder patchSequenceDoIfMatch: [ :string | unchangedNumberOfLines := unchangedNumberOfLines + 1]
		ifInsert: [ :string | additions := additions + 1]
		ifRemove: [ :string | deletions := deletions + 1]

]

{ #category : #testing }
ThVisCardSourceNode >> connectMovementRefactorWith: aNode [
	| nextHead myTail |
	self allMovementRefactorNodesDo: [ :n | n == aNode ifTrue: [ ^ self ] ].

	nextHead := aNode firstMovementRefactorNode.
	myTail := self lastMovementRefactorNode.
	myTail nextMovementRefactorNode: nextHead.
	nextHead previousMovementRefactorNode: myTail.
	
]

{ #category : #accessing }
ThVisCardSourceNode >> deletions [
	deletions ifNil: [ self computeDiffStats ].
	^ deletions
]

{ #category : #accessing }
ThVisCardSourceNode >> description [
	self wasModified ifFalse: [ 
		^ '{1} {2}' format: {self nodeTypeName . name}
	].

	^ '{1} {2}
	
{3} additions.
{4} deletions.
{5} unchanged lines.
' format: {self nodeTypeName . name . self additions asString . self deletions asString . self unchangedNumberOfLines}
]

{ #category : #ui }
ThVisCardSourceNode >> diff [
	^ diff ifNil: [diff := (TextDiffBuilder from: self oldSource to: self newSource) buildDisplayPatch]
]

{ #category : #accessing }
ThVisCardSourceNode >> firstMovementRefactorNode [
	previousMovementRefactorNode ifNil: [ ^ self ].
	^ previousMovementRefactorNode firstMovementRefactorNode
]

{ #category : #ui }
ThVisCardSourceNode >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: -9>
	composite text
		title: 'Diff';
		format: [ self diff ]
		
]

{ #category : #testing }
ThVisCardSourceNode >> hasChildren [
	^ children isNotEmpty
]

{ #category : #accessing }
ThVisCardSourceNode >> hasMovementRefactor [
	^ hasMovementRefactor
]

{ #category : #accessing }
ThVisCardSourceNode >> hasMovementRefactor: anObject [
	hasMovementRefactor := anObject
]

{ #category : #initialization }
ThVisCardSourceNode >> initialize [
	super initialize.
	children := Dictionary new.
	hasMovementRefactor := false.
	
]

{ #category : #testing }
ThVisCardSourceNode >> isClass [
	^ false
]

{ #category : #testing }
ThVisCardSourceNode >> isFalseMovementPositive [
	| addedCount removedCount |
	addedCount := 0.
	removedCount := 0.
	self allMovementRefactorNodesDo: [ :n |
		n wasAdded ifTrue: [
			addedCount := addedCount + 1
		].
		n wasRemoved ifTrue: [
			removedCount := removedCount + 1
		].
	].
	^ addedCount = 0 or: [ removedCount = 0 ]
]

{ #category : #testing }
ThVisCardSourceNode >> isFile [
	^ false
]

{ #category : #testing }
ThVisCardSourceNode >> isFunction [
	^ false
]

{ #category : #testing }
ThVisCardSourceNode >> isSimpleMovementRefactor [
	| addedCount removedCount |
	addedCount := 0.
	removedCount := 0.
	self allMovementRefactorNodesDo: [ :n |
		n wasAdded ifTrue: [
			addedCount := addedCount + 1
		].
		n wasRemoved ifTrue: [
			removedCount := removedCount + 1
		].
	].
	^ addedCount = removedCount
]

{ #category : #accessing }
ThVisCardSourceNode >> lastMovementRefactorNode [
	nextMovementRefactorNode ifNil: [ ^ self ].
	^ nextMovementRefactorNode lastMovementRefactorNode
]

{ #category : #accessing }
ThVisCardSourceNode >> model: aModel old: isOldModel [
	isOldModel ifTrue: [ self oldModel: aModel ] ifFalse: [ self newModel: aModel ]
]

{ #category : #accessing }
ThVisCardSourceNode >> movementRefactorNodesDo: aBlock [
	| position |
	position := self firstMovementRefactorNode.
	[ position ] whileNotNil: [
		position ~~ self ifTrue: [ 
			aBlock value: position.
		].
		position := position nextMovementRefactorNode
	]
]

{ #category : #accessing }
ThVisCardSourceNode >> name [
	^ name
]

{ #category : #accessing }
ThVisCardSourceNode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> newLoc [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNode >> newModel [
	^ newModel
]

{ #category : #accessing }
ThVisCardSourceNode >> newModel: anObject [
	newModel := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> newSource [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNode >> newSourceBagOfWords [
	^ newSourceBagOfWords
]

{ #category : #accessing }
ThVisCardSourceNode >> newSourceBagOfWords: anObject [
	newSourceBagOfWords := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> nextMovementRefactorNode [
	^ nextMovementRefactorNode
]

{ #category : #accessing }
ThVisCardSourceNode >> nextMovementRefactorNode: anObject [
	nextMovementRefactorNode := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> nodeTypeName [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNode >> oldLoc [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNode >> oldModel [
	^ oldModel
]

{ #category : #accessing }
ThVisCardSourceNode >> oldModel: anObject [
	oldModel := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> oldSource [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNode >> oldSourceBagOfWords [
	^ oldSourceBagOfWords
]

{ #category : #accessing }
ThVisCardSourceNode >> oldSourceBagOfWords: anObject [
	oldSourceBagOfWords := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> palette [
	^ palette
]

{ #category : #accessing }
ThVisCardSourceNode >> palette: anObject [
	palette := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> parent [
	^ parent
]

{ #category : #accessing }
ThVisCardSourceNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
ThVisCardSourceNode >> previousMovementRefactorNode [
	^ previousMovementRefactorNode
]

{ #category : #accessing }
ThVisCardSourceNode >> previousMovementRefactorNode: anObject [
	previousMovementRefactorNode := anObject
]

{ #category : #'as yet unclassified' }
ThVisCardSourceNode >> proxyForMetric: aMetric [
	^ ThVisCardSourceNodeMetricProxy new node: self;
		metric: aMetric;
		yourself
]

{ #category : #accessing }
ThVisCardSourceNode >> shouldBeCountedAsMovement [
	self isSimpleMovementRefactor ifFalse: [ ^ true ].
	parent hasMovementRefactor ifTrue: [ ^ false ].
	^ true
]

{ #category : #testing }
ThVisCardSourceNode >> shouldBeFiltered [
	^ self hasMovementRefactor and: [ self shouldBeCountedAsMovement not ]
]

{ #category : #testing }
ThVisCardSourceNode >> shouldBeTestedForCodeSimilarity [
	^ false
]

{ #category : #accessing }
ThVisCardSourceNode >> sourceBagOfWords [
	^ sourceBagOfWords ifNil: [ oldSourceBagOfWords + newSourceBagOfWords ]
]

{ #category : #accessing }
ThVisCardSourceNode >> unchangedNumberOfLines [
	unchangedNumberOfLines ifNil: [ self computeDiffStats ].
	^ unchangedNumberOfLines
]

{ #category : #testing }
ThVisCardSourceNode >> wasAdded [
	^ oldModel isNil
]

{ #category : #testing }
ThVisCardSourceNode >> wasInternallyModified [
	^ self wasAdded not and: [self wasRemoved not and: [self wasModified]]
]

{ #category : #testing }
ThVisCardSourceNode >> wasModified [
	^ wasModified ifNil: [ wasModified := self checkForModification ]
]

{ #category : #testing }
ThVisCardSourceNode >> wasRemoved [
	^ newModel isNil
]

{ #category : #enumerating }
ThVisCardSourceNode >> withAllChildrenDo: aBlock [
	aBlock value: self.
	self allChildrenDo: aBlock
]
