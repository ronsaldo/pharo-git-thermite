structure diff
addMethod: method to: parentNode
	| node |
	node := parentNode childPrefix: 'method ' named: method name ifAbsentPut: [ ThVisPyCardSourceNodeFunction new name: method name ].
	node model: method old: buildingOldModel.