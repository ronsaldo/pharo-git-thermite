*Thermite-GitHub
asHTTPDateString
	| monthName |
	offset isZero ifFalse: [ ^ self asUTC asHTTPDateString ].
	monthName := #(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec) at: self month.
	^ ByteString streamContents: [ :out |
		out nextPutAll: self dayOfWeekAbbreviation; nextPutAll: ', ';
			print: self dayOfMonth; space;
			nextPutAll: monthName; space;
			print: self year; space;
			nextPutAll: (self hour printStringPadded: 2); nextPut: $:;
			nextPutAll: (self minute printStringPadded: 2); nextPut: $:;
			nextPutAll: (self second printStringPadded: 2); nextPutAll: ' GMT'.
	]