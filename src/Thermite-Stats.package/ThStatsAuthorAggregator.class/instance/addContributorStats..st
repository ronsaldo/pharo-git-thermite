adding
addContributorStats: aRepository
	aRepository contributorStats do: [ :contributorStats |
		(self authorFor: contributorStats author) addCommits: contributorStats total.
	].