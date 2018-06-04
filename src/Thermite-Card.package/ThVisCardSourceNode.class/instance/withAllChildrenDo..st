enumerating
withAllChildrenDo: aBlock
	aBlock value: self.
	self allChildrenDo: aBlock