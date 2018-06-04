accessing
unchangedNumberOfLines
	unchangedNumberOfLines ifNil: [ self computeDiffStats ].
	^ unchangedNumberOfLines