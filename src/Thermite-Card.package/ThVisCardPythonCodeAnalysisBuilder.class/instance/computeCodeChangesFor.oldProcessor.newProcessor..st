as yet unclassified
computeCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor
	sourceRootNode := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addFiles: oldProcessor files to: sourceRootNode.
	buildingOldModel := false.
	self addFiles: newProcessor files to: sourceRootNode.
	self computeSimilaritiesForChanges: sourceRootNode.