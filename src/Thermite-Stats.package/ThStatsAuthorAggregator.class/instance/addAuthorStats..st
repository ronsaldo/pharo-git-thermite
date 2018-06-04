adding
addAuthorStats: anAuthor
	| author |
	author := self authorFor: anAuthor.
	author followerCount: anAuthor followerCount.
	author publicRepositoryCount: anAuthor publicRepositoryCount.
	"author publicRepositoryCount > 0 ifTrue: [
		author publicRepositoriesForkCount: 0.
		anAuthor repositories do: [ :repo |
			author publicRepositoriesForkCount: author publicRepositoriesForkCount + repo forksCount.
		]
	]"
	