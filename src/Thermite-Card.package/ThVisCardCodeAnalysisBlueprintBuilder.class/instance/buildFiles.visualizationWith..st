visualization
buildFiles: files visualizationWith: b
	| panels |
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextAbove: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: self palette filesBackground.
	b shape shape allShapes first color: self palette textColor.
	b nodes: files forEach: [ :file |
		b interaction
			noInteractions;
			popupText: [:p | p node description] solidBackgroundColor: self palette popupBackgroundColor.

		b shape rectangle
			withTextAbove: #title;
			borderColor: Color transparent;
			color: self palette filesBackground.
		b shape shape allShapes first color: self palette packagePanelTitleColor.

		panels := { ThVisCardSourceNodeSubElementBuildProxy new node: file; action: [self addLinesChangedChartOf: file visualizationWith: b]; title: 'Lines' }.
		file hasChildren ifTrue: [ 
			panels := panels , {ThVisCardSourceNodeSubElementBuildProxy new node: file; action: [self buildFileContent: file visualizationWith: b]; title: 'Content'}
		].
	
		b nodes: panels forEach: [ :el |
			el action value
		].
	
		b layout horizontalLine.
	].