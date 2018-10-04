Trait {
	#name : #TThCardPySourceNode,
	#category : 'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
TThCardPySourceNode >> newLoc [
	^ self newModel ifNil: [ 0 ] ifNotNil: [ self newModel loc ]
]

{ #category : #accessing }
TThCardPySourceNode >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ self newModel getSource ]
]

{ #category : #accessing }
TThCardPySourceNode >> oldLoc [
	^ self oldModel ifNil: [ 0 ] ifNotNil: [ self oldModel loc ]
]

{ #category : #accessing }
TThCardPySourceNode >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ self oldModel getSource ]
]
