as yet unclassified
proxyForMetric: aMetric
	^ ThVisCardFileNodeMetricProxy new node: self;
		metric: aMetric;
		yourself