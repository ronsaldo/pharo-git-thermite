accessing
files
	^ (json at: 'files') collect: [ :fileJson | ThGitHubCommitFileMetadata new
		session: session;
		json: fileJson;
		yourself
	]