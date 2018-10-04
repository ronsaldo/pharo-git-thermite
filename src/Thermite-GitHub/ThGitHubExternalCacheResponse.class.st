Class {
	#name : #ThGitHubExternalCacheResponse,
	#superclass : #Object,
	#instVars : [
		'code',
		'message',
		'content'
	],
	#category : 'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubExternalCacheResponse >> changeMessage [
	^ self message
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> code [
	^ code
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> content [
	^ content
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> content: anObject [
	content := anObject
]

{ #category : #testing }
ThGitHubExternalCacheResponse >> isBad [
	^ code < 0
]

{ #category : #testing }
ThGitHubExternalCacheResponse >> isGood [
	^ code >= 0
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> message [
	^ message
]

{ #category : #accessing }
ThGitHubExternalCacheResponse >> message: anObject [
	message := anObject
]
