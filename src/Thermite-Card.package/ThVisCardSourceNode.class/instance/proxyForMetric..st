as yet unclassified
proxyForMetric: aMetric
	^ ThVisCardSourceNodeMetricProxy new node: self;
		metric: aMetric;
		yourself