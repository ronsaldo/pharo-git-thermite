accessing
allNewSource
	| source |
	^ ByteString streamContents: [ :out |
		out nextPutAll: self newSource.
		children do: [ :child |
			source := child newSource.
			source ifNotEmpty: [ 
				out cr; nextPutAll: source
			]
		]
	]