Class {
	#name : #ThVisCard,
	#superclass : #Object,
	#instVars : [
		'commits',
		'pullRequest',
		'treeView',
		'width'
	],
	#category : 'Thermite-Card'
}

{ #category : #accessing }
ThVisCard >> commits [
	^ commits
]

{ #category : #accessing }
ThVisCard >> commits: anObject [
	commits := anObject
]

{ #category : #ui }
ThVisCard >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: -9>
	composite text
		title: 'Diff';
		format: [ pullRequest diff ]
		
]

{ #category : #accessing }
ThVisCard >> pullRequest [
	^ pullRequest
]

{ #category : #accessing }
ThVisCard >> pullRequest: anObject [
	pullRequest := anObject
]

{ #category : #accessing }
ThVisCard >> treeView [
	^ treeView
]

{ #category : #accessing }
ThVisCard >> treeView: anObject [
	treeView := anObject
]

{ #category : #accessing }
ThVisCard >> width [
	^ width
]

{ #category : #accessing }
ThVisCard >> width: anObject [
	width := anObject
]
