accessing
pullRequests
	^ session getCachedResource: url , '/pulls' arrayElementClass: ThGitHubPullRequest parent: self