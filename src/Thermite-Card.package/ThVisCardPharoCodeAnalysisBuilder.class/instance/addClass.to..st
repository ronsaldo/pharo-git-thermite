adding
addClass: class to: parentNode
	| node |
	node := parentNode childPrefix: 'class ' named: class name ifAbsentPut: [ ThVisPhCardSourceNodeClass new name: class name ].
	node model: class old: buildingOldModel.
	self addMethods: class methods to: node