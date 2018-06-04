git commands
doNumStat
	| statString parts repo oldVersionBranchName newVersionBranchName |
	self flag: 'Handle the renamed files in a better way.'.
	
	self fetch.
	statString :=  self repository executeGitCommandOutput: self numStatCommand.
	repo := self repository.
	oldVersionBranchName := self parentName.
	newVersionBranchName := self name.
	^ (statString lines reject: [:line | line includesSubstring: ' => '] thenCollect: [ :line |
		parts := line splitOn: Character tab.
		(parts first isAllDigits and: [ parts second isAllDigits ]) ifTrue: [
			ThGitHubModifiedFileStats new
				filename: parts last;
				additions: parts first asNumber;
				deletions: parts second asNumber;
				repository: repo;
				oldVersionBranchName: oldVersionBranchName;
				newVersionBranchName: newVersionBranchName
				yourself
		] ifFalse: [
			nil
		]
	]) select: #isNotNil