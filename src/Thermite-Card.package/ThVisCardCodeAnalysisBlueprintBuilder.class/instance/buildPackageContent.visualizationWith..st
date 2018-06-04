visualization
buildPackageContent: package visualizationWith: b
	self buildClassesOf: package visualizationWith: b.
	b layout tree;
		ifNotConnectedThen: RTGridLayout new.