charts
plotStackBarMetrics: metrics title: title
	| panel usedMetrics label sum height width widthScaleFactor barShape bars barPanel popup metricsSum barLabelPanel barsAndLabels |
	usedMetrics := metrics select: [:m | m isNotNil and: [m value third ~= 0] ]
		thenCollect: [ :m | ThVisCardCodeAnalysisBlueprintResumeElement builder: codeAnalyzer value: m].
	usedMetrics ifEmpty: [ ^ nil ].
	
	sum := 0.
	usedMetrics do: [ :metric | sum := sum + metric value third ].
	
	panel := RTBox new
		color: self palette metricPlotBackground;
		element.
	view add: panel.

	label := (RTLabel new text: title; color: self palette textColor) element.
	view add: label.

	height := 20	.
	width := 300.
	widthScaleFactor := width / sum.

	barLabelPanel := RTBox new
		color: Color white;
		borderColor: Color black;
		element.
	view add: barLabelPanel.
	
	barPanel := RTBox new
		color: Color white;
		borderColor: Color black;
		element.
	view add: barPanel.
	
	barShape := RTBox new
		color: [ :metric | metric value first ];
		width: [:metric | metric value third * widthScaleFactor];
		height: height.
	bars := usedMetrics collect: [ :metric | barShape elementOn: metric ].
	
	metricsSum := 0.
	usedMetrics do: [ :metric | metricsSum := metricsSum + metric value third ].
	view addAll: bars.
	
	popup := RTPopup new text: [ :metric | metric value second format: { metric value third } ].
	popup backgroundColor: self palette popupBackgroundColor.
	bars do: [ :b | b @ popup ].
	
	RTHorizontalLineLayout new gapSize: 0; on: bars.
	
	RTNest new on: barPanel nest: bars.
	
	barsAndLabels := {
		(self label: 0 color: self palette stackBarLabelColor) element.
		barPanel.
		(self label: metricsSum color: self palette stackBarLabelColor) element
	}.
	
	view add: barsAndLabels first; add: barsAndLabels last.
	RTHorizontalLineLayout on: barsAndLabels.
	RTNest new on: barLabelPanel nest: barsAndLabels.

	RTVerticalLineLayout on: {label . barLabelPanel}.
	RTNest new on: panel nest: {label . barLabelPanel}.
	
	^ panel