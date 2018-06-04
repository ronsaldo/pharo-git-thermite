monticello
mcDiff
	| session repository pullRequest |
	session := ThGitHubSession forMainUser.
	
	repository := (session user: projectOwner text repository: projectName text).
	repository cloneRepo.

	pullRequest := repository pullRequestNumber: pullRequestNumber text asInteger.
	pullRequest mcDiff