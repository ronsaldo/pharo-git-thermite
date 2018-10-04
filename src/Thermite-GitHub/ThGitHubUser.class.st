Class {
	#name : #ThGitHubUser,
	#superclass : #ThGitHubResource,
	#category : 'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubUser >> email [
	^ json at: 'email'
]

{ #category : #accessing }
ThGitHubUser >> followerCount [
	^ json at: 'followers'
]

{ #category : #accessing }
ThGitHubUser >> login [
	^ json at: 'login'
]

{ #category : #accessing }
ThGitHubUser >> name [
	^ json at: 'name'
]

{ #category : #accessing }
ThGitHubUser >> organizations [
	^ session getCachedResource: url , '/orgs' arrayElementClass: ThGitHubOrganization
]

{ #category : #printing }
ThGitHubUser >> printOn: aStream [
	super printOn: aStream.
	aStream space; print: self validName
]

{ #category : #accessing }
ThGitHubUser >> publicRepositoryCount [
	^ json at: 'public_repos'
]

{ #category : #accessing }
ThGitHubUser >> repositories [
	^ session getCachedResource: url , '/repos' arrayElementClass: ThGitHubRepository
]

{ #category : #accessing }
ThGitHubUser >> validName [
	self name ifNotNil: [ :result | ^ result ].
	self email ifNotNil: [ :result | ^ result ].
	self login ifNotNil: [ :result | ^ result ].
	self halt.
]
