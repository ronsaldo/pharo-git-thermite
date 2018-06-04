visualization
buildCodeChangesDetails
	| b |
	b := self newMondrianBuilder.
	b interaction noInteractions.
	
	self build: b changes: sourceRootNode.
	b layout grid.
	
	self buildSimilaryEdgesOn: b.
	b build.
	^ b