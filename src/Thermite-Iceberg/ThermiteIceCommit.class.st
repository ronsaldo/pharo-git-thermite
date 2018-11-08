Class {
	#name : #ThermiteIceCommit,
	#superclass : #Object,
	#instVars : [
		'repository',
		'model',
		'parentModel',
		'numStat'
	],
	#category : #'Thermite-Iceberg'
}

{ #category : #accessing }
ThermiteIceCommit >> commits [
	^ ThStatsCommits new elements: { self }
]

{ #category : #monticello }
ThermiteIceCommit >> convertIcePackages: packages [
	| mcPackage |
	^ packages collect: [ :icePackage |
		icePackage mcSnapshotInRepository asRingPackageNamedForThermite: icePackage name
	]
]

{ #category : #monticello }
ThermiteIceCommit >> convertIcePackages: packages model: versionModel [
	^ packages collect: [ :icePackage |
		(versionModel snapshotFor: icePackage) asRingPackageNamedForThermite: icePackage name
	]
]

{ #category : #accessing }
ThermiteIceCommit >> doNumStat [
	| changes |
	changes := OrderedCollection new.
	(parentModel entity changesTo: model entity) do: [ :change |
		changes add: (ThermiteIceModifiedFileStats new
			path: change path;
			sourceCommitModel: parentModel;
			targetCommitModel: model)
	].

	^ changes
]

{ #category : #monticello }
ThermiteIceCommit >> loadOldAndNewMonticelloPackages [
	^ {
		self convertIcePackages: parentModel entity packages model: parentModel entity.
		self convertIcePackages: model entity packages model: model entity.
	}
]

{ #category : #accessing }
ThermiteIceCommit >> mergeable [
	^ nil
]

{ #category : #accessing }
ThermiteIceCommit >> model [
	^ model
]

{ #category : #accessing }
ThermiteIceCommit >> model: anObject [
	model := anObject
]

{ #category : #accessing }
ThermiteIceCommit >> numStat [
	^ numStat ifNil: [ numStat := self doNumStat ]
]

{ #category : #accessing }
ThermiteIceCommit >> parentModel [
	^ parentModel
]

{ #category : #accessing }
ThermiteIceCommit >> parentModel: anObject [
	parentModel := anObject
]

{ #category : #accessing }
ThermiteIceCommit >> repository [
	^ repository
]

{ #category : #accessing }
ThermiteIceCommit >> repository: anObject [
	repository := anObject
]

{ #category : #accessing }
ThermiteIceCommit >> title [ 
	^ model comment
]
