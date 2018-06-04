initialization
browseLocalRepository
	| localRepoPath |
	localRepoPath := UIManager default chooseDirectory: 'Local Git Repository Folder'.
	localRepoPath ifNil: [ ^ self ].
	localRepositoryPath text: localRepoPath fullName.