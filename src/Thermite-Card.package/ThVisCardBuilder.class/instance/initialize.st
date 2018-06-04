initialization
initialize
	super initialize.
	view := RTView new.
	view @ RTDraggableView.
	view @ RTZoomableView.
	 
	pullRequests := OrderedCollection new.
	visitCards := OrderedCollection new.
	navigationButtons := #().
	useStackBarPlot := true.
	withoutUnchangedLines := false.
	self nullCodeAnalyzer.