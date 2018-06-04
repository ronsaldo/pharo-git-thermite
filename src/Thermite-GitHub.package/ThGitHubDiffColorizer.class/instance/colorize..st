as yet unclassified
colorize: aStringOrText
	| text char color lastStop runs count |
	text := aStringOrText asText.
	lastStop := 0.
	runs := RunArray new.
	
	self string: aStringOrText linesDo: [ :start  :stop |
		char := aStringOrText at: start.
		color := LineColors at: char ifAbsent: [nil].
		color ifNotNil: [
			count := start - lastStop - 1.
			runs add: #() withOccurrences: count.

			count := stop - start + 1.
			runs add: color withOccurrences: count.

			lastStop := stop.
		]
	].

	runs add: #() withOccurrences: aStringOrText size - runs size.
	self assert: runs size = aStringOrText size.
	text setString: text string setRunsChecking: runs.
	^ text