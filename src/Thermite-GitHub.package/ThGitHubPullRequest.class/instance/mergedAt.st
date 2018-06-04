accessing
mergedAt
	^ DateAndTime fromString: (json at: 'merged_at')