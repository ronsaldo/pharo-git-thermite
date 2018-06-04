as yet unclassified
authorFor: gitHubAuthor
	^ authors at: gitHubAuthor validName ifAbsentPut: [ ThStatsAuthor new name: gitHubAuthor validName]