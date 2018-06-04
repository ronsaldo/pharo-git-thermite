resources
user: userName repository: repositoryName
	^ self getCachedResource: 'https://api.github.com/repos/' , userName , '/', repositoryName class: ThGitHubRepository