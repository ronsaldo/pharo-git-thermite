Class {
	#name : #ThStatsCommits,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'Thermite-Stats-Local'
}

{ #category : #'private-model' }
ThStatsCommits >> allItems [
	^ elements
]

{ #category : #accessing }
ThStatsCommits >> elements: anObject [
	elements := anObject
]
