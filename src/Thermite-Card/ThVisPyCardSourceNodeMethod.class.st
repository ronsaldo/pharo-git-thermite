Class {
	#name : #ThVisPyCardSourceNodeMethod,
	#superclass : #ThVisCardSourceNodeMethod,
	#traits : 'TThCardPySourceNode',
	#classTraits : 'TThCardPySourceNode classTrait',
	#category : 'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
ThVisPyCardSourceNodeMethod >> newLoc [
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeMethod >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource trim ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeMethod >> oldLoc [
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeMethod >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource trim ]
]
