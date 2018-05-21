Class {
	#name : #ThVisPyCardSourceNodeFile,
	#superclass : #ThVisCardSourceNodeFile,
	#traits : 'TThCardPySourceNode',
	#classTraits : 'TThCardPySourceNode classTrait',
	#category : #'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
ThVisPyCardSourceNodeFile >> newLoc [
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFile >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFile >> oldLoc [
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]
]

{ #category : #accessing }
ThVisPyCardSourceNodeFile >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource ]
]
