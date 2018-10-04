Class {
	#name : #ThVisPhCardSourceNodeMethod,
	#superclass : #ThVisCardSourceNodeMethod,
	#traits : 'TThCardPhSourceNode',
	#classTraits : 'TThCardPhSourceNode classTrait',
	#category : 'Thermite-Card-CodeAnalysis-Pharo'
}

{ #category : #testing }
ThVisPhCardSourceNodeMethod >> isTest [
	^ self name beginsWith: 'test'
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeMethod >> newLoc [
	^ self countLines: self newSource
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeMethod >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeMethod >> oldLoc [
	^ self countLines: self oldSource
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeMethod >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]
]
