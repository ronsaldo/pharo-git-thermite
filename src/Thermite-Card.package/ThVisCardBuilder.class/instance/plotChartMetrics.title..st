charts
plotChartMetrics: metrics title: title
	| panel b ds grapherElements usedMetrics label grapherPanel |
	usedMetrics := metrics select: [:m | m value third ~= 0]
		thenCollect: [ :m | ThVisCardCodeAnalysisBlueprintResumeElement builder: codeAnalyzer value: m].
	usedMetrics ifEmpty: [ ^ nil ].

	panel := RTBox new
		color: self palette metricPlotBackground;
		element.
	view add: panel.

	label := (RTLabel new text: title; color: self palette textColor) element.
	view add: label.

	grapherPanel := RTBox new
		color: Color veryLightGray muchLighter;
		elementOn: (ThVisCardCodeAnalysisBlueprintResumeElement builder: self).	
	view add: grapherPanel.

	b := RTGrapher new.
	b extent: (b extent /2).	
	
	ds := RTData new.
	ds interaction
		highlight;
		popupText: [ :m | m value second format: {m value third asString}].
	ds points: usedMetrics.
	ds barShape
		color: [ :m | m value first ];
		width: 10.
	ds y: [:m | m value third].
	b add: ds.
	b axisY noDecimal; withThousandsSeparator.
	b axisX
		noTick;
		noLabel.

	b build.
	
	grapherElements := b view elements.
	view addAll: grapherElements.
	view addAll: b view edges.
	RTNest new
        on: grapherPanel nestRootOf: grapherElements.

	RTVerticalLineLayout on: { label . grapherPanel }.
	RTNest new
        on: panel nestRootOf: {label . grapherPanel}.
	
	^ panel