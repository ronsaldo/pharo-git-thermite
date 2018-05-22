Class {
	#name : #ThStatsRepository,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#classVars : [
		'ProcessWaitDelay'
	],
	#category : #'Thermite-Stats-Local'
}

{ #category : #initialization }
ThStatsRepository class >> initialize [
	ProcessWaitDelay := Delay forMilliseconds: 100
]

{ #category : #accessing }
ThStatsRepository class >> path: aPath [
	^ self new path: aPath
]

{ #category : #'git commands' }
ThStatsRepository >> clonePath [
	^ path fullName
]

{ #category : #'git commands' }
ThStatsRepository >> cloneRepo [
]

{ #category : #operations }
ThStatsRepository >> commit: commitName [
	^ ThStatsCommit new repository: self; name: commitName
]

{ #category : #operations }
ThStatsRepository >> commit: commitName parent: parentCommitName [
	^ ThStatsCommit new repository: self; name: commitName; parent: parentCommitName
]

{ #category : #'git commands' }
ThStatsRepository >> executeGitCommand: command [
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		runAndWaitOnExitDo: [ :process :outString :errString |
	]
]

{ #category : #'git commands' }
ThStatsRepository >> executeGitCommandOutput: command [
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		redirectStdout;
		redirectStderr;
		runAndWaitPollingEvery: (Delay forMilliseconds: 20) retrievingStreams: true onExitDo: [ :process :outString :errString |
			^ outString
	]
]

{ #category : #accessing }
ThStatsRepository >> getFileContent: filename ifAbsent: aBlock [
	| fullReference |
	fullReference := path resolve: filename asFileReference.
	^ fullReference exists ifTrue: [ fullReference contents ] ifFalse: [ aBlock value ]
]

{ #category : #accessing }
ThStatsRepository >> path: aPath [
	path := aPath asFileReference.
]
