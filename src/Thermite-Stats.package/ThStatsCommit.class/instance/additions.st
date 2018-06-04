accessing
additions
	additions ifNil: [ 
		additions := 0.
		self numStat do: [ :stat |
			additions := additions + stat additions
		].
	].
	^ additions