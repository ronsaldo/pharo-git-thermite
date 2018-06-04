adding
addNavigation: label view: viewBlock priority: priority
	viewBlock ifNil: [ ^ self ].
	self addNavigationButtonWithModel: (ThVisNavigationButtonViewBlockModel new label: label; view: viewBlock) priority: priority.