initialization
buildVisualization
	| session repository pullRequest builder analyzer view |
	session := ThGitHubSession forMainUser.
	
	repository := (session user: projectOwner text repository: projectName text).
	repository cloneRepo.

	pullRequest := repository pullRequestNumber: pullRequestNumber text asInteger.

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

	view := builder
    addPullRequest: pullRequest;
    vertical;
    inspect