Class {
	#name : #ThVisPyCardSourceNodeFunction,
	#superclass : #ThVisCardSourceNodeFunction,
	#traits : 'TThCardPySourceNode',
	#classTraits : 'TThCardPySourceNode classTrait',
	#category : 'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
ThVisPyCardSourceNodeFunction >> newLoc [
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFunction >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource trim ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFunction >> oldLoc [
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFunction >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource trim ]
]
