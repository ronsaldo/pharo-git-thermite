arithmetic
< other
	self with: other do: [ :i :a :b |
		a < b ifTrue: [ ^ true ].
		a > b ifTrue: [ ^ false ].
	].
	^ false
