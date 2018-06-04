visualization
buildCodeChangesFor: pullRequest
	self computeCodeChangesFor: pullRequest.
	sourceRootNode withAllChildrenDo: [ :node | node palette: self palette ].

	^ {
		self linesOfCodeChart .
		self classesMetricsChart.
		self methodsMetricsChart.
	} select: #isNotNil