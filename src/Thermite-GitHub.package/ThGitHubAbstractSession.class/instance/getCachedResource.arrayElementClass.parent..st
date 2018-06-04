resources
getCachedResource: url arrayElementClass: arrayElementClass parent: elementParent
	^ self getCachedResource: url class: (ThGitHubArrayResource new elementClass: arrayElementClass) parent: elementParent