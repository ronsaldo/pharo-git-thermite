accessing
mergedBy
	^ self getUser: (json at: 'merged_by')