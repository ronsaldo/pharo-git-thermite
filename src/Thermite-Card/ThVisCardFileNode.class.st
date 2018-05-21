Class {
	#name : #ThVisCardFileNode,
	#superclass : #Object,
	#instVars : [
		'palette',
		'model'
	],
	#category : #'Thermite-Card'
}

{ #category : #accessing }
ThVisCardFileNode >> additions [
	^ model additions
]

{ #category : #accessing }
ThVisCardFileNode >> basename [
	^ self filename asFileReference basename
]

{ #category : #visualization }
ThVisCardFileNode >> changeColor [
	self wasAdded ifTrue: [ ^ self palette additionsColor ].
	self wasRemoved ifTrue: [ ^ self palette deletionsColor ].
	^ self wasModified ifTrue: [ self palette nodeModifiedColor ] ifFalse: [ self palette unchangedColor ]
]

{ #category : #accessing }
ThVisCardFileNode >> deletions [
	^ model deletions
]

{ #category : #accessing }
ThVisCardFileNode >> description [
	^ '{1}

Additions: {2}
Deletions: {3}
Unchanged Lines: {4}
Border Color: {5}
' format: { self filename . self additions asString. self deletions asString. self unchangedNumberOfLines asString. self tooltipForBorderColor }
]

{ #category : #accessing }
ThVisCardFileNode >> filename [
	^ model filename
]

{ #category : #ui }
ThVisCardFileNode >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: 1>
	model gtInspectorDiffIn: composite
]

{ #category : #accessing }
ThVisCardFileNode >> isTest [
	^ self filename includesSubstring: 'test' caseSensitive: false
]

{ #category : #accessing }
ThVisCardFileNode >> model [
	^ model
]

{ #category : #accessing }
ThVisCardFileNode >> model: anObject [
	model := anObject
]

{ #category : #accessing }
ThVisCardFileNode >> palette [
	^ palette
]

{ #category : #accessing }
ThVisCardFileNode >> palette: anObject [
	palette := anObject
]

{ #category : #'as yet unclassified' }
ThVisCardFileNode >> proxyForMetric: aMetric [
	^ ThVisCardFileNodeMetricProxy new node: self;
		metric: aMetric;
		yourself
]

{ #category : #accessing }
ThVisCardFileNode >> tooltipForBorderColor [
	^ self isTest ifTrue: [ 'The file could have unit tests.' ] ifFalse: [ 'Normal file.' ]
]

{ #category : #accessing }
ThVisCardFileNode >> totalNumberOfLines [
	^ self unchangedNumberOfLines + self additions + self deletions
]

{ #category : #accessing }
ThVisCardFileNode >> unchangedNumberOfLines [
	^ model oldVersionLineCount - model deletions
]

{ #category : #testing }
ThVisCardFileNode >> wasAdded [
	^ model wasAdded
]

{ #category : #testing }
ThVisCardFileNode >> wasModified [
	^ model wasModified
]

{ #category : #testing }
ThVisCardFileNode >> wasRemoved [
	^ model wasRemoved
]
