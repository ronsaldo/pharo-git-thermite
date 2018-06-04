accessing
deletions
	deletions ifNil: [ self computeDiffStats ].
	^ deletions