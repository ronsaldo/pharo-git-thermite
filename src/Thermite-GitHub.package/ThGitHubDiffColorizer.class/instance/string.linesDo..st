enumerating
string: aStringOrText linesDo: aBlock
	| s startPosition c |
	s := ReadStream on: aStringOrText.
	startPosition := 0.
	[s atEnd] whileFalse: [
		c := s next.
		c = Character cr ifTrue: [
			aBlock value: startPosition  + 1 value: s position.
			s peek = Character lf ifTrue: [ s next ].
			startPosition := s position.
		] ifFalse: [ 
			c = Character lf ifTrue: [
				aBlock value: startPosition + 1 value: s position.
				startPosition := s position.
			]
		]
	]