visualization
build: b changes: changes
	| panels |
	b interaction popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextAbove: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: self palette packageBackground.
	b shape shape allShapes first color: self palette textColor.
	b nodes: changes children forEach: [ :package |
		b interaction
			noInteractions;
			popupText: [:p | p node description] solidBackgroundColor: self palette popupBackgroundColor.

		b shape rectangle
			withTextAbove: #title;
			borderColor: Color transparent;
			color: self palette filesBackground.
		b shape shape allShapes first color: self palette packagePanelTitleColor.

		panels := { ThVisCardSourceNodeSubElementBuildProxy new node: package; action: [self addLinesChangedChartOf: package visualizationWith: b]; title: 'Lines' }.
		package hasChildren ifTrue: [ 
			panels := panels , {ThVisCardSourceNodeSubElementBuildProxy new node: package; action: [self buildPackageContent: package visualizationWith: b]; title: 'Content'}
		].

		b nodes: panels forEach: [ :el |
			el action value
		].
	
		b layout horizontalLine.
	].

	b layout grid.