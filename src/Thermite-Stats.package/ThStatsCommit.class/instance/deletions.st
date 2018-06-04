accessing
deletions
	deletions ifNil: [ 
		deletions := 0.
		self numStat do: [ :stat |
			deletions := deletions + stat deletions
		].
	].
	^ deletions