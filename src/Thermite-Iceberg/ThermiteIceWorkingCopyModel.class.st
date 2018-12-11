Class {
	#name : #ThermiteIceWorkingCopyModel,
	#superclass : #Object,
	#instVars : [
		'workingCopy',
		'comment'
	],
	#category : #'Thermite-Iceberg-Mock'
}

{ #category : #accessing }
ThermiteIceWorkingCopyModel >> comment [
	^ comment
]

{ #category : #accessing }
ThermiteIceWorkingCopyModel >> comment: aString [
	comment := aString
]

{ #category : #accessing }
ThermiteIceWorkingCopyModel >> entity [
	^ workingCopy
]

{ #category : #accessing }
ThermiteIceWorkingCopyModel >> workingCopy [
	^ workingCopy
]

{ #category : #accessing }
ThermiteIceWorkingCopyModel >> workingCopy: anObject [
	workingCopy := anObject
]
