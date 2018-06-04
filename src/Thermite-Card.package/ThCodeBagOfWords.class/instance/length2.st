arithmetic
length2
	| result |
	result := 0.
	data valuesDo: [ :v | result := result + (v*v) ].
	^ result