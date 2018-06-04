adding
addNavigation: label text: textBlock priority: priority
	textBlock ifNil: [ ^ self ].
	self addNavigationButtonWithModel: (ThVisNavigationButtonTextBlockModel new label: label; text: textBlock) priority: priority.