Class {
	#name : #ThVisCardCodeAnalysisBuilder,
	#superclass : #Object,
	#instVars : [
		'view',
		'palette',
		'cardBuilder'
	],
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBuilder >> buildCodeChangesFor: pullRequest [
	| result |
	result := RTBox element.
	view add: result.
	^ result
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> cardBuilder [
	^ cardBuilder
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> cardBuilder: anObject [
	cardBuilder := anObject
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBuilder >> codeChangesView [
	^ nil
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBuilder >> filterModifiedFiles: files [
	^ files
]

{ #category : #'gt inspect' }
ThVisCardCodeAnalysisBuilder >> gtInspectorCodeChangesViewIn: composite [
	<gtInspectorPresentationOrder: -9>
	^ nil
]

{ #category : #'instance creation' }
ThVisCardCodeAnalysisBuilder >> newMondrianBuilder [
	^ cardBuilder newMondrianBuilder
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> palette [
	^ palette
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> palette: anObject [
	palette := anObject
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBuilder >> plotMetrics: metrics title: title [
	^ cardBuilder plotMetrics: metrics title: title
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> view [
	^ view
]

{ #category : #accessing }
ThVisCardCodeAnalysisBuilder >> view: anObject [
	view := anObject
]
