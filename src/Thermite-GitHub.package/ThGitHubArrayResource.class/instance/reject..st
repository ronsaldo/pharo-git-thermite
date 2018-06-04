enumerating
reject: aBlock
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifFalse: [ 
				out nextPut: element
			]
		]
	]