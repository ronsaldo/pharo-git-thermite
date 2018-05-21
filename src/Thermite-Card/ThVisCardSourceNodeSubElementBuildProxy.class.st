Class {
	#name : #ThVisCardSourceNodeSubElementBuildProxy,
	#superclass : #ThVisCardSourceNodeProxy,
	#instVars : [
		'action',
		'title'
	],
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #accessing }
ThVisCardSourceNodeSubElementBuildProxy >> action [
	^ action
]

{ #category : #accessing }
ThVisCardSourceNodeSubElementBuildProxy >> action: anObject [
	action := anObject
]

{ #category : #accessing }
ThVisCardSourceNodeSubElementBuildProxy >> title [
	^ title
]

{ #category : #accessing }
ThVisCardSourceNodeSubElementBuildProxy >> title: anObject [
	title := anObject
]
