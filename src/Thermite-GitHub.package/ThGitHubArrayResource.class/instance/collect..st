enumerating
collect: aBlock
	^ Array streamContents: [ :out |
		self do: [ :element |
			out nextPut: (aBlock value: element)
		]
	]