accessing
additions
	additions ifNil: [ self computeDiffStats ].
	^ additions