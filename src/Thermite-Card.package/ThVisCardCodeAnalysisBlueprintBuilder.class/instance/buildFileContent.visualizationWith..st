visualization
buildFileContent: file visualizationWith: b
	self buildClassesOf: file visualizationWith: b.
	self buildFunctionsOf: file visualizationWith: b.
	b layout tree;
		ifNotConnectedThen: RTGridLayout new.