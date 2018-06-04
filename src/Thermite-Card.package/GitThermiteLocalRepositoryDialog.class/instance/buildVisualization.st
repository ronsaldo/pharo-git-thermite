initialization
buildVisualization
	| repo commit builder analyzer view |
	repo := ThStatsRepository path: localRepositoryPath text.
	commit := repo commit: commitSha text parent: parentCommitSha text.

	builder := ThVisCardBuilder new.
	analyzer := builder codeAnalyzer: language selectedItem new.
	
	analyzer allContent.
	addUnchangedLines state ifFalse: [
		builder withoutUnchangedLines.
		analyzer withoutUnchangedLines
	].

	addUnmodifiedMethods state ifFalse: [
		analyzer onlyModifiedFunctions.
	].
	
	addUnmodifiedClasses state ifFalse: [ 
		analyzer onlyModifiedClasses.
	].

	builder
    addCommit: commit;
    vertical;
    inspect