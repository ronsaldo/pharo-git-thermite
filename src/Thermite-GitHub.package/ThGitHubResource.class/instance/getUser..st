utilities
getUser: userData
	userData ifNil: [ ^ nil ].
	^ session getCachedResource: (userData at: 'url') class: ThGitHubUser