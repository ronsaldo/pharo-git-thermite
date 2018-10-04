Class {
	#name : #ThVisCardSourceNodeFile,
	#superclass : #ThVisCardSourceNode,
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #testing }
ThVisCardSourceNodeFile >> isFile [
	^ true
]

{ #category : #accessing }
ThVisCardSourceNodeFile >> nodeTypeName [
	^ 'File'
]
