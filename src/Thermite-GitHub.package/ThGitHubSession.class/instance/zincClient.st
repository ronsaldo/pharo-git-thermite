public
zincClient
	currentClient ifNotNil: [ ^ currentClient ].
	currentClient := ZnClient new
		accept: GitHubMimeType;
		username: username password: password.
	^ currentClient