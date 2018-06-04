initialization
mcDiff
	| repo commit |
	repo := ThStatsRepository path: localRepositoryPath text.
	commit := repo commit: commitSha text parent: parentCommitSha text.
	commit mcDiff