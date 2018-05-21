Class {
	#name : #ThVisCardFileNodeMetricProxy,
	#superclass : #Object,
	#instVars : [
		'node',
		'metric'
	],
	#category : #'Thermite-Card'
}

{ #category : #accessing }
ThVisCardFileNodeMetricProxy >> description [
	^ node description
]

{ #category : #ui }
ThVisCardFileNodeMetricProxy >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: 1>
	node gtInspectorDiffIn: composite
]

{ #category : #accessing }
ThVisCardFileNodeMetricProxy >> metric [
	^ metric
]

{ #category : #accessing }
ThVisCardFileNodeMetricProxy >> metric: anObject [
	metric := anObject
]

{ #category : #accessing }
ThVisCardFileNodeMetricProxy >> node [
	^ node
]

{ #category : #accessing }
ThVisCardFileNodeMetricProxy >> node: anObject [
	node := anObject
]
