"
A GitHubSessionTest is a test class for testing the behavior of GitHubSession
"
Class {
	#name : #ThGitHubSessionTest,
	#superclass : #TestCase,
	#category : #'Thermite-GitHub-Tests'
}

{ #category : #tests }
ThGitHubSessionTest >> testUserPassword [
	| session |
	session := ThGitHubSession username: 'hello' password: '123456'.
	self assert: session username equals: 'hello'.
	self assert: session password equals: '123456'.
	
]

{ #category : #tests }
ThGitHubSessionTest >> testUserToken [
	| session |
	session := ThGitHubSession username: 'hello' token: '123456'.
	self assert: session username equals: 'hello'.
	self assert: session token equals: '123456'.
	
]
