tests
testUserToken
	| session |
	session := ThGitHubSession username: 'hello' token: '123456'.
	self assert: session username equals: 'hello'.
	self assert: session token equals: '123456'.
	