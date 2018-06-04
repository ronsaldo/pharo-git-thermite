adding
add: anIndex
	| node |
	node := data nodeAt: anIndex ifAbsentPut: [ 0 ].
	node value: node value + 1