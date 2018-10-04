Class {
	#name : #ThGitHubOrganization,
	#superclass : #ThGitHubResource,
	#category : 'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubOrganization >> repositories [
	^ session getCachedResource: (json at: 'repos_url') arrayElementClass: ThGitHubRepository
]
