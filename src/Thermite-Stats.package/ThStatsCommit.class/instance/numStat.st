accessing
numStat
	^ numStat ifNil: [ numStat := self doNumStat ]