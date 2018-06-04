structure diff
doBuildCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor builder: b
	| root |
	root := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addFiles: oldProcessor files to: root.
	buildingOldModel := false.
	self addFiles: newProcessor files to: root.

	self buildFiles: root children visualizationWith: b.
	b layout grid