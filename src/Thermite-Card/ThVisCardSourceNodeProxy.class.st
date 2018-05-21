Class {
	#name : #ThVisCardSourceNodeProxy,
	#superclass : #Object,
	#instVars : [
		'node'
	],
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #ui }
ThVisCardSourceNodeProxy >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: -9>
	^ node gtInspectorDiffIn: composite
]

{ #category : #accessing }
ThVisCardSourceNodeProxy >> node [
	^ node
]

{ #category : #accessing }
ThVisCardSourceNodeProxy >> node: anObject [
	node := anObject
]
