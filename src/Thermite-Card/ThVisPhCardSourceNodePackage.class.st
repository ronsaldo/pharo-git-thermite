Class {
	#name : #ThVisPhCardSourceNodePackage,
	#superclass : #ThVisCardSourceNodePackage,
	#traits : 'TThCardPhSourceNode',
	#classTraits : 'TThCardPhSourceNode classTrait',
	#instVars : [
		'newSource',
		'oldSource'
	],
	#category : 'Thermite-Card-CodeAnalysis-Pharo'
}

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> buildNewSource [
	^ ByteString streamContents: [ :out |
		children do: [ :child |
			out nextPutAll: child allNewSource
		]
	]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> buildOldSource [
	^ ByteString streamContents: [ :out |
		children do: [ :child |
			out nextPutAll: child allOldSource
		]
	]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> newLoc [
	^ self countLines: self newSource
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> newSource [
	^ newSource ifNil: [ newSource := self buildNewSource ]
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> oldLoc [
	^ self countLines: self oldSource
]

{ #category : #'instance creation' }
ThVisPhCardSourceNodePackage >> oldSource [
	^ oldSource ifNil: [ oldSource := self buildOldSource ]
]
