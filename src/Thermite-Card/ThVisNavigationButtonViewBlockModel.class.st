Class {
	#name : #ThVisNavigationButtonViewBlockModel,
	#superclass : #ThVisNavigationButtonModel,
	#instVars : [
		'view'
	],
	#category : 'Thermite-Card'
}

{ #category : #ui }
ThVisNavigationButtonViewBlockModel >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: label;
		initializeView: view
]

{ #category : #accessing }
ThVisNavigationButtonViewBlockModel >> view [
	^ view
]

{ #category : #accessing }
ThVisNavigationButtonViewBlockModel >> view: anObject [
	view := anObject
]
