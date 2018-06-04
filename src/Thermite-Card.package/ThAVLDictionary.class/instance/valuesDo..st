enumerating
valuesDo: aBlock
	^ self do: [ :n | aBlock value: n value ]