accessing
openPullRequests
	^ session getCachedResource: url , '/pulls?state=open' arrayElementClass: ThGitHubPullRequest parent: self