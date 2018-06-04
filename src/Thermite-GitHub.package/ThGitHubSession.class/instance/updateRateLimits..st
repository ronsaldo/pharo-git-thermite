rate limit
updateRateLimits: response
	rateLimit := (response headers at: 'X-RateLimit-Limit') asInteger.
	rateLimitRemaining := (response headers at: 'X-RateLimit-Remaining') asInteger.
	rateLimitReset := (response headers at: 'X-RateLimit-Reset') asInteger.