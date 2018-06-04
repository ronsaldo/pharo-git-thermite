as yet unclassified
matrixForSimilaritiesOf: aCollection
	| matrix a b similarity |
	matrix := Matrix zeros: aCollection size.
	1 to: aCollection size do: [ :i |
		i to: aCollection size do: [ :j |
			a := aCollection at: i.
			b := aCollection at: j.
			similarity := a cosineSimilarityWith: b.
			matrix
				at: i at: j put: similarity;
				at: j at: i put: similarity
		]
	].
	^ matrix 