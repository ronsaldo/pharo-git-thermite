visualization
linesOfCodeChart
	| unchangedLoc addedLoc removedLoc |
	unchangedLoc := 0.
	addedLoc := 0.
	removedLoc := 0.
	sourceRootNode children do: [ :node |
		unchangedLoc := unchangedLoc + node unchangedNumberOfLines.
		addedLoc := addedLoc + node additions.
		removedLoc := removedLoc + node deletions.
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added lines of code' . addedLoc }.
		{ self palette deletionsColor . '{1} - Removed lines of code' . removedLoc }.
		withoutUnchangedLines ifFalse: [ { self palette unchangedColor . '{1} - Unchanged lines of code' . unchangedLoc }].
	} title: 'Lines of Code'.