enumerating
select: aBlock thenCollect: collectBlock
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifTrue: [ 
				out nextPut: (collectBlock value: element)
			]
		]
	]