accessing
legend
	| legendView |
	legendView := RTView new.
	legendView @ RTDraggableView.
	legendView @ RTZoomableView.
	legendView canvas color: self palette viewBackground.
	self legendForView: legendView.
	^ legendView