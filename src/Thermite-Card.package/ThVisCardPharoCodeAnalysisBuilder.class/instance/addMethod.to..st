adding
addMethod: method to: parentNode
	| node |
	node := parentNode childPrefix: 'method ' named: method name ifAbsentPut: [ ThVisPhCardSourceNodeMethod new name: method name ].
	node model: method old: buildingOldModel.