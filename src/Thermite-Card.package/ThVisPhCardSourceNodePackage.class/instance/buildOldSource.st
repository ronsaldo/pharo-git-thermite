instance creation
buildOldSource
	^ ByteString streamContents: [ :out |
		children do: [ :child |
			out nextPutAll: child allOldSource
		]
	]