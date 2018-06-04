accessing
contributorStats
	^ session getCachedResource: url , '/stats/contributors' arrayElementClass: ThGitHubContributorStat