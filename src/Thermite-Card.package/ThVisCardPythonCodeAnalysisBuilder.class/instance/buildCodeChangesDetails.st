as yet unclassified
buildCodeChangesDetails
	| b |
	b := self newMondrianBuilder.
	b interaction noInteractions.
	
	self buildFiles: sourceRootNode children visualizationWith: b.
	b layout grid.
	
	b build.
	^ b