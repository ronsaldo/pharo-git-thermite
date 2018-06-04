arithmetic
cosineSimilarityWith: other
	| result leftLength2 rightLength2 den |
	result := 0.
	leftLength2 := 0.
	rightLength2 := 0.	
	self with: other do: [ :i :a :b |
		leftLength2 := leftLength2 + (a*a).
		rightLength2 := rightLength2 + (b*b).	
		result := result + (a*b)
	].
	
	den := leftLength2 sqrt * rightLength2 sqrt.
	(den closeTo: 0) ifTrue: [ ^ 0 ].
	^ result / den