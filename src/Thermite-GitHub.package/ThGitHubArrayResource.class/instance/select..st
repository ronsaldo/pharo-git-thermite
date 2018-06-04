enumerating
select: aBlock
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifTrue: [ 
				out nextPut: element
			]
		]
	]