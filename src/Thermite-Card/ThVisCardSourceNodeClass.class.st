Class {
	#name : #ThVisCardSourceNodeClass,
	#superclass : #ThVisCardSourceNode,
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #testing }
ThVisCardSourceNodeClass >> isClass [
	^ true
]

{ #category : #accessing }
ThVisCardSourceNodeClass >> newSuperName [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNodeClass >> nodeTypeName [
	^ 'Class'
]

{ #category : #accessing }
ThVisCardSourceNodeClass >> oldSuperName [
	self subclassResponsibility
]

{ #category : #accessing }
ThVisCardSourceNodeClass >> unchangedSuperName [
	| oldName |
	oldName := self oldSuperName.
	^ oldName = self newSuperName ifTrue: [ oldName ] ifFalse: [ nil ]
]
