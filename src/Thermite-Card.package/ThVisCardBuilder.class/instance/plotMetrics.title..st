charts
plotMetrics: metrics title: title
	^ useStackBarPlot ifTrue: [self plotStackBarMetrics: metrics title: title] ifFalse: [ self plotChartMetrics: metrics title: title ]