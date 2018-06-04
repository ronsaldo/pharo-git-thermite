structure diff
addClass: class to: parentNode
	| node |
	node := parentNode childPrefix: 'class ' named: class name ifAbsentPut: [ ThVisPyCardSourceNodeClass new name: class name ].
	node model: class old: buildingOldModel.
	self addMethods: class methods to: node