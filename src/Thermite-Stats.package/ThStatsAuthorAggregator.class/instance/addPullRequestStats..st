adding
addPullRequestStats: aRepository
	| author |
	aRepository allPullRequests do: [ :pullRequest |
		author := self authorFor: pullRequest user.
		author addPullRequest: pullRequest
	].