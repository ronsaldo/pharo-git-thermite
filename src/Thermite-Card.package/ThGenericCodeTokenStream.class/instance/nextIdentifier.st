accessing
nextIdentifier
	^ ByteString streamContents: [ :out |
		[self isIdentifierMiddle: in peek] whileTrue: [ out nextPut: in next ]
	]