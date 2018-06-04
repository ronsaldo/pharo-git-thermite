adding
addContributorsToRepository: aRepository
	self addContributorStats: aRepository.
	self addPullRequestStats: aRepository.
