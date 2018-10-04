Class {
	#name : #ThVisCardCodeAnalysisBlueprintResumeElement,
	#superclass : #Object,
	#instVars : [
		'blueprintBuilder',
		'value'
	],
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement class >> builder: blueprintBuilder [
	^ self new blueprintBuilder: blueprintBuilder; yourself
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement class >> builder: blueprintBuilder value: aValue [
	^ self new blueprintBuilder: blueprintBuilder; value: aValue; yourself
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement >> blueprintBuilder [
	^ blueprintBuilder
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement >> blueprintBuilder: anObject [
	blueprintBuilder := anObject
]

{ #category : #ui }
ThVisCardCodeAnalysisBlueprintResumeElement >> detailVisualization [
	value ifNil: [ ^ nil ].
	value size < 4 ifTrue: [ ^ nil ].
	^ value fourth
]

{ #category : #ui }
ThVisCardCodeAnalysisBlueprintResumeElement >> gtInspectorAllCodeChangesIn: composite [
	<gtInspectorPresentationOrder: -9>
	composite roassal2
		title: 'All code changed';
		initializeView: [ blueprintBuilder buildCodeChangesDetails ]
		
]

{ #category : #ui }
ThVisCardCodeAnalysisBlueprintResumeElement >> gtInspectorDetailsIn: composite [
	<gtInspectorPresentationOrder: -10>
	| visualization |
	visualization := self detailVisualization.
	visualization ifNil: [ ^ self ].
	
	composite roassal2
		title: 'Details';
		initializeView: visualization
		
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement >> value [
	^ value
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintResumeElement >> value: anObject [
	value := anObject
]
