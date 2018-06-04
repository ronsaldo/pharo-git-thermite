operations
commit: commitName parent: parentCommitName
	^ ThStatsCommit new repository: self; name: commitName; parent: parentCommitName