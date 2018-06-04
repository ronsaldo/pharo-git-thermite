structure diff
addFunction: function to: parentNode
	| node |
	node := parentNode childPrefix: 'method ' named: function name ifAbsentPut: [ ThVisPyCardSourceNodeFunction new name: function name ].
	node model: function old: buildingOldModel.
