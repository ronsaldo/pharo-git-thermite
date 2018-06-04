accessing
allPullRequests
	^ session getCachedResource: url , '/pulls?state=all' arrayElementClass: ThGitHubPullRequest parent: self