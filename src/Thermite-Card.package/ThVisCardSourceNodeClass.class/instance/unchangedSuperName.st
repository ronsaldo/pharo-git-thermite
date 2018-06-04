accessing
unchangedSuperName
	| oldName |
	oldName := self oldSuperName.
	^ oldName = self newSuperName ifTrue: [ oldName ] ifFalse: [ nil ]