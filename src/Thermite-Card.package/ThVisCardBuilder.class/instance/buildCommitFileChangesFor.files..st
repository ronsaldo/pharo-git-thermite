file view
buildCommitFileChangesFor: pullRequest files: files
	| b displayedLinesSum normalizationFactor fileSize |
	b := self newMondrianBuilder.

	b interaction popupText: [:file |
		self tooltipForFile: file
	] solidBackgroundColor: self palette popupBackgroundColor.

	b shape box
		withTextAbove: #basename;
		borderColor: self palette normalNodeBorderColor;
		color: #changeColor.
	b shape shape allShapes first color: [:file | file isTest ifTrue: [ self palette testNodeBorderdColor ] ifFalse: [self palette textColor] ].
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.

	b nodes: (files sorted: [:a :fb | a totalNumberOfLines > fb totalNumberOfLines ]) forEach: [ :file |
		displayedLinesSum := file additions + file deletions.
		withoutUnchangedLines ifFalse: [ 
			displayedLinesSum := displayedLinesSum + file unchangedNumberOfLines
		].
	
		fileSize := displayedLinesSum sqrt*0.25.
		normalizationFactor := fileSize * FileChartHeight / (displayedLinesSum max: 1).
		 
		b shape box
			color: [:proxy | proxy metric second];
			width: FileChartWidth;
			height: [:proxy | proxy metric third].
		b interaction
			noInteractions;
			popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
		
		b nodes: ({
			withoutUnchangedLines ifFalse: [
				file proxyForMetric: {file unchangedNumberOfLines asString , ' unchanged lines' . self palette unchangedColor. file unchangedNumberOfLines*normalizationFactor}
			].
			file proxyForMetric: {file additions asString , ' additions' . self palette additionsColor . file additions* normalizationFactor}.
			file proxyForMetric: {file deletions asString , ' deletions' . self palette deletionsColor . file deletions*normalizationFactor}
		} select: [:el | el isNotNil and: [el metric third ~= 0]]).
		b layout verticalLine verticalGap: 0.
	].
	
	"b layout horizontalFlow maxWidth: currentVisitCard width asFloat."
	b layout grid.
	b build.
	
	^ b