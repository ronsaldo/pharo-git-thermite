instance creation
buildNewSource
	^ ByteString streamContents: [ :out |
		children do: [ :child |
			out nextPutAll: child allNewSource
		]
	]