Extension { #name : #DateAndTime }

{ #category : #'*Thermite-GitHub' }
DateAndTime >> asHTTPDateString [
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
]

{ #category : #'*Thermite-GitHub' }
DateAndTime class >> fromHTTPDateString: aString [
	| parts day month year time timezone |
	parts := aString splitOn: ' '.
	day := parts second asInteger.
	month := #(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec) indexOf: parts third.
	year := parts fourth asInteger.
	time := Time fromString: parts fifth.
	timezone := parts sixth.

	^ DateAndTime year: year month: month day: day hour: time hour minute: time minute second: time second offset: 0 hours

]
