accessing
nextSpecial
	^ ByteString streamContents: [ :out |
		[self isSpecial: in peek] whileTrue: [ out nextPut: in next ]
	]