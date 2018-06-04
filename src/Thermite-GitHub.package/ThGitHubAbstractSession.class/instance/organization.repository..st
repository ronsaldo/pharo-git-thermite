resources
organization: organizationName repository: repositoryName
	^ self getCachedResource: 'https://api.github.com/repos/' , organizationName , '/', repositoryName class: ThGitHubRepository