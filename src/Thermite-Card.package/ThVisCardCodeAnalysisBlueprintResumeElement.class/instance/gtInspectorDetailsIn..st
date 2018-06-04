ui
gtInspectorDetailsIn: composite
	<gtInspectorPresentationOrder: -10>
	| visualization |
	visualization := self detailVisualization.
	visualization ifNil: [ ^ self ].
	
	composite roassal2
		title: 'Details';
		initializeView: visualization
		