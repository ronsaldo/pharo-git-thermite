Class {
	#name : #ThVisNavigationButtonTextBlockModel,
	#superclass : #ThVisNavigationButtonModel,
	#instVars : [
		'text'
	],
	#category : 'Thermite-Card'
}

{ #category : #ui }
ThVisNavigationButtonTextBlockModel >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: -8>
	composite text
		title: 'Diff';
		format: text
		
]

{ #category : #accessing }
ThVisNavigationButtonTextBlockModel >> text [
	^ text
]

{ #category : #accessing }
ThVisNavigationButtonTextBlockModel >> text: anObject [
	text := anObject
]
