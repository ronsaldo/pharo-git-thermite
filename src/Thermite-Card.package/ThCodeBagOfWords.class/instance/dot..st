arithmetic
dot: other
	| result |
	result := 0.
	self with: other do: [ :i :a :b |
		result := result + (a*b)
	].
	^ result
