as yet unclassified
formForSimilaritiesOf: aCollection threshold: aThreshold
	| form a b similarity gray color |
	form := Form extent: (aCollection size @ aCollection size) depth: 32.
	1 to: aCollection size do: [ :i |
		i to: aCollection size do: [ :j |
			a := aCollection at: i.
			b := aCollection at: j.
			similarity := a cosineSimilarityWith: b.
			gray := similarity asFloat min: 1.0.
			gray < aThreshold ifTrue: [ gray := 0.0 ].
			color := Color r: gray g: gray b: gray.
			form colorAt: (i @ j) put: color.
			form colorAt: (j @ i) put: color.
		]
	].
	^ form 