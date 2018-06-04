as yet unclassified
computeSimilaritiesForChanges: changes
	self computeSimilaritiesForMethodChanges: changes.
	self computeSimilaritiesForClassChanges: changes.
	self computeSimilaritiesGroupsFor: changes.