enumerating
reject: aBlock thenCollect: collectBlock
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifFalse: [ 
				out nextPut: (collectBlock value: element)
			]
		]
	]