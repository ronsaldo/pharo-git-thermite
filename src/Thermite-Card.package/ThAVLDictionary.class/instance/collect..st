enumerating
collect: aBlock
	| result destinationIndex |
	result := Array new: size.
	destinationIndex := 1.
	self valuesDo: [ :v |
		result at: destinationIndex put: (aBlock value: v).
		destinationIndex := destinationIndex + 1
	].
	^ result