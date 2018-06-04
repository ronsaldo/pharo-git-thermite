*Thermite-GitHub
fromHTTPDateString: aString
	| parts day month year time timezone |
	parts := aString splitOn: ' '.
	day := parts second asInteger.
	month := #(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec) indexOf: parts third.
	year := parts fourth asInteger.
	time := Time fromString: parts fifth.
	timezone := parts sixth.

	^ DateAndTime year: year month: month day: day hour: time hour minute: time minute second: time second offset: 0 hours
