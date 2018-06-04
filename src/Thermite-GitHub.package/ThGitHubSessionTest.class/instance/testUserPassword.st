tests
testUserPassword
	| session |
	session := ThGitHubSession username: 'hello' password: '123456'.
	self assert: session username equals: 'hello'.
	self assert: session password equals: '123456'.
	