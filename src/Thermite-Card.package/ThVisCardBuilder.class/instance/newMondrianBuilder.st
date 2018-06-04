instance creation
newMondrianBuilder
	| builder |
	builder := RTMondrian new.
	builder view canvas color: self palette viewBackground.
	builder view @ RTDraggableView.
	builder view @ RTZoomableView.
	^ builder