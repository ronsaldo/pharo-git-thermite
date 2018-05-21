Class {
	#name : #ThVisPhCardSourceNodeClass,
	#superclass : #ThVisCardSourceNodeClass,
	#traits : 'TThCardPhSourceNode',
	#classTraits : 'TThCardPhSourceNode classTrait',
	#category : #'Thermite-Card-CodeAnalysis-Pharo'
}

{ #category : #accessing }
ThVisPhCardSourceNodeClass >> allNewSource [
	| source |
	^ ByteString streamContents: [ :out |
		out nextPutAll: self newSource.
		children do: [ :child |
			source := child newSource.
			source ifNotEmpty: [ 
				out cr; nextPutAll: source
			]
		]
	]
]

{ #category : #accessing }
ThVisPhCardSourceNodeClass >> allOldSource [
	| source |
	^ ByteString streamContents: [ :out |
		out nextPutAll: self oldSource.
		children do: [ :child |
			source := child oldSource.
			source ifNotEmpty: [ 
				out cr; nextPutAll: source
			]
		]
	]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeClass >> newLoc [
	^ self countLines: self newSource
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeClass >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: #definitionSource
]

{ #category : #accessing }
ThVisPhCardSourceNodeClass >> newSuperName [
	^ newModel ifNil: [ nil ] ifNotNil: [ newModel superclassName ]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodeClass >> oldLoc [
	^ self countLines: self oldSource
]

{ #category : #accessing }
ThVisPhCardSourceNodeClass >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: #definitionSource
]

{ #category : #accessing }
ThVisPhCardSourceNodeClass >> oldSuperName [
	^ oldModel ifNil: [ nil ] ifNotNil: [ oldModel superclassName ]
]
