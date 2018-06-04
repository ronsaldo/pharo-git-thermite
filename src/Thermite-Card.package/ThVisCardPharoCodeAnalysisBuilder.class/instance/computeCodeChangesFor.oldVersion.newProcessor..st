as yet unclassified
computeCodeChangesFor: pullRequest oldVersion: oldVersion newProcessor: newVersion
	| root |
	root := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addPackages: oldVersion to: root.
	buildingOldModel := false.
	self addPackages: newVersion to: root.
	^ root