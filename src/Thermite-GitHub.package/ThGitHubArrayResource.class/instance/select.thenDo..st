enumerating
select: aBlock thenDo: doBlock
	self do: [ :element |
		(aBlock value: element) ifTrue: [ 
			doBlock value: element
		]
	]
