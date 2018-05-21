Class {
	#name : #ThVisCardSourceNodeMetricProxy,
	#superclass : #ThVisCardSourceNodeProxy,
	#instVars : [
		'metric'
	],
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #accessing }
ThVisCardSourceNodeMetricProxy >> metric [
	^ metric
]

{ #category : #accessing }
ThVisCardSourceNodeMetricProxy >> metric: anObject [
	metric := anObject
]
