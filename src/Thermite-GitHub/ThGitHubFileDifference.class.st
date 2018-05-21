Class {
	#name : #ThGitHubFileDifference,
	#superclass : #Object,
	#instVars : [
		'filename',
		'oldContent',
		'newContent'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubFileDifference >> filename [
	^ filename
]

{ #category : #accessing }
ThGitHubFileDifference >> filename: anObject [
	filename := anObject
]

{ #category : #testing }
ThGitHubFileDifference >> isValid [
	^ newContent isNotNil and: [ oldContent isNotNil ]
]

{ #category : #accessing }
ThGitHubFileDifference >> newContent [
	^ newContent
]

{ #category : #accessing }
ThGitHubFileDifference >> newContent: anObject [
	newContent := anObject
]

{ #category : #accessing }
ThGitHubFileDifference >> oldContent [
	^ oldContent
]

{ #category : #accessing }
ThGitHubFileDifference >> oldContent: anObject [
	oldContent := anObject
]
