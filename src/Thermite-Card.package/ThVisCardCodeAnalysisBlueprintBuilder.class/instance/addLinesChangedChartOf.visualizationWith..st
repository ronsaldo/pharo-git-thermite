visualization
addLinesChangedChartOf: node visualizationWith: b
	| displayedLinesSum nodeSize normalizationFactor |
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		borderColor: self palette normalNodeBorderColor;
		borderWidth: 3;
		color: #changeColor.

	displayedLinesSum := node additions + node deletions.
	withoutUnchangedLines ifFalse: [ 
		displayedLinesSum := displayedLinesSum + node unchangedNumberOfLines
	].
	
	nodeSize := displayedLinesSum sqrt * 0.25.
	normalizationFactor := nodeSize * NodeChartHeight / (displayedLinesSum max: 1.0).
	b shape box
		color: [:proxy | proxy metric second];
		width: NodeChartWidth;
		height: [:proxy | proxy metric third].
	b interaction
		noInteractions;
		popupText: [:el | node description ]
		solidBackgroundColor: self palette popupBackgroundColor.
	node hasMovementRefactor ifTrue: [ 
		b nodes: ({
			node proxyForMetric: {displayedLinesSum asString , ' moved lines' . self palette movementColor . node unchangedNumberOfLines*normalizationFactor}.
			}).
		] ifFalse: [ 
			b nodes: ({
				withoutUnchangedLines ifFalse: [
					node proxyForMetric: {node unchangedNumberOfLines asString , ' unchanged lines' . self palette leafUnchangedColor . node unchangedNumberOfLines*normalizationFactor}
				].
			node proxyForMetric: {node additions asString , ' additions' . self palette additionsColor . node additions* normalizationFactor}.
			node proxyForMetric: {node deletions asString , ' deletions' . self palette deletionsColor . node deletions*normalizationFactor}
		} select: [:el | el isNotNil and: [el metric third ~= 0] ]).
	].
	b layout verticalLine verticalGap: 0.