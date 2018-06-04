enumerating
reject: aBlock thenDo: doBlock
	self do: [ :element |
		(aBlock value: element) ifFalse: [ 
			doBlock value: element
		]
	]
