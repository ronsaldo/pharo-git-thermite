Class {
	#name : #ThVisPyCardSourceNodeClass,
	#superclass : #ThVisCardSourceNodeClass,
	#traits : 'TThCardPySourceNode',
	#classTraits : 'TThCardPySourceNode classTrait',
	#category : 'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> newLoc [
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource trim ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> newSuperName [
	^ newModel ifNil: [ nil ] ifNotNil: [ newModel superclassName ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> oldLoc [
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource trim ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeClass >> oldSuperName [
	^ oldModel ifNil: [ nil ] ifNotNil: [ oldModel superclassName ]
]
