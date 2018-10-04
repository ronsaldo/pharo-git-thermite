Class {
	#name : #ThGitHubCommit,
	#superclass : #ThGitHubResource,
	#category : 'Thermite-GitHub'
}

{ #category : #stats }
ThGitHubCommit >> additions [
	^ (json at: #stats) at: #additions
]

{ #category : #accessing }
ThGitHubCommit >> author [
	^ self getUser: (json at: 'author')
]

{ #category : #accessing }
ThGitHubCommit >> changeMessage [
	^ self message
]

{ #category : #accessing }
ThGitHubCommit >> commiter [
	^ self getUser: (json at: 'commiter')
]

{ #category : #stats }
ThGitHubCommit >> deletions [
	^ (json at: #stats) at: #deletions
]

{ #category : #accessing }
ThGitHubCommit >> files [
	^ (json at: 'files') collect: [ :fileJson | ThGitHubCommitFileMetadata new
		session: session;
		json: fileJson;
		yourself
	]
]

{ #category : #accessing }
ThGitHubCommit >> message [
	^ (json at: 'commit') at: 'message'
]

{ #category : #accessing }
ThGitHubCommit >> parentsSha [
	^ (json at: 'parents') collect: [:parent | parent at: 'sha' ]
]

{ #category : #accessing }
ThGitHubCommit >> sha [
	^ json at: 'sha'
]
