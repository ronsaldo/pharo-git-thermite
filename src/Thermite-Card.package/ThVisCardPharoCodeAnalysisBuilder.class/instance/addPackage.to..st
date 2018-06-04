adding
addPackage: package to: parentNode
	| packageNode |
	packageNode := parentNode childPrefix: 'package ' named: package name ifAbsentPut: [ ThVisPhCardSourceNodePackage new name: package name ].
	packageNode model: package old: buildingOldModel.
	self addClasses: package definedClasses to: packageNode.
