accessing
addPullRequests: pullRequests
	pullRequests do: [ :pullRequest | self addPullRequest: pullRequest ]