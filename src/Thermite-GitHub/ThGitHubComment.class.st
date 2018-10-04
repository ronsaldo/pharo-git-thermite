Class {
	#name : #ThGitHubComment,
	#superclass : #ThGitHubResource,
	#category : 'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubComment >> content [
	^ self json at: 'body'
]

{ #category : #accessing }
ThGitHubComment >> user [
	^ self getUser: (json at: 'user')
]
