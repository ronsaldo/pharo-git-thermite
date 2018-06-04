as yet unclassified
computeCodeChangesFor: pullRequest
	| versions oldVersion newVersion |
	versions := pullRequest loadOldAndNewMonticelloPackages.
	oldVersion := versions first.
	newVersion := versions second.
	
	sourceRootNode := self computeCodeChangesFor: pullRequest oldVersion: oldVersion newProcessor: newVersion.
	self computeSimilaritiesForChanges: sourceRootNode.
