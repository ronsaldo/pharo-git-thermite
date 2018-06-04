accessing
nextNumber
	^ ByteString streamContents: [ :out |
		"Whole part"
		[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
		in peek = $. ifTrue: [
			"Fractional part"
			out nextPut: in next.
			[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
		
			"Exponent"
			('eE' includes: in peek) ifTrue: [
				out nextPut: in next.
				('+-' includes: in peek) ifTrue: [
					out nextPut: in next.
				].
			
				[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
			]
		]
	]