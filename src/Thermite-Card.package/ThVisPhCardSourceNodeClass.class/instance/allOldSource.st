accessing
allOldSource
	| source |
	^ ByteString streamContents: [ :out |
		out nextPutAll: self oldSource.
		children do: [ :child |
			source := child oldSource.
			source ifNotEmpty: [ 
				out cr; nextPutAll: source
			]
		]
	]