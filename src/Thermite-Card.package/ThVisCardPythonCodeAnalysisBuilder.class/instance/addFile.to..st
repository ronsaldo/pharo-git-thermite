structure diff
addFile: file to: parentNode
	| fileNode |
	fileNode := parentNode childPrefix: 'file ' named: file filename ifAbsentPut: [ ThVisPyCardSourceNodeFile new name: file filename ].
	fileNode model: file old: buildingOldModel.
	
	self
		addClasses: file classes to: fileNode;
		addFunctions: file functions to: fileNode