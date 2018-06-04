accessing
pullRequestNumber: number
	^ session getCachedResource: url , '/pulls/' , number asString class: ThGitHubPullRequest parent: self