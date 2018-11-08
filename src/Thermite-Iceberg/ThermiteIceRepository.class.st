Class {
	#name : #ThermiteIceRepository,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Thermite-Iceberg'
}

{ #category : #operations }
ThermiteIceRepository >> commit: commitModel parent: parentCommitModel [
	^ ThermiteIceCommit new repository: self; model: commitModel; parentModel: parentCommitModel
]

{ #category : #accessing }
ThermiteIceRepository >> model [
	^ model
]

{ #category : #accessing }
ThermiteIceRepository >> model: anObject [
	model := anObject
]
