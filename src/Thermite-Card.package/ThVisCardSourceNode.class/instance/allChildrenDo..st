enumerating
allChildrenDo: aBlock
	children do: [:child |
		aBlock value: child.
		child allChildrenDo: aBlock
	]