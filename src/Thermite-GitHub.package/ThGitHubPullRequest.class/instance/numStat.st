git commands
numStat
	^ numStat ifNil: [ numStat := self doNumStat ]