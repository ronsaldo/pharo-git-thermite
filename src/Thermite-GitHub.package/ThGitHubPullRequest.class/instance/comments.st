accessing
comments
	^ session getCachedResource: (json at: 'comments_url') arrayElementClass: ThGitHubComment