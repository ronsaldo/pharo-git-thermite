Class {
	#name : #ThGitHubCommitFileMetadata,
	#superclass : #ThGitHubResource,
	#category : #'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubCommitFileMetadata >> additions [
	^ json at: 'additions'
]

{ #category : #accessing }
ThGitHubCommitFileMetadata >> changes [
	^ json at: 'changes'
]

{ #category : #accessing }
ThGitHubCommitFileMetadata >> deletions [
	^ json at: 'deletions'
]

{ #category : #accessing }
ThGitHubCommitFileMetadata >> filename [
	^ json at: 'filename'
]

{ #category : #accessing }
ThGitHubCommitFileMetadata >> sha [
	^ json at: 'sha'
]
