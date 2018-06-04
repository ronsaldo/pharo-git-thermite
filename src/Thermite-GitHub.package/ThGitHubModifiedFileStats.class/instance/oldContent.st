accessing
oldContent
	^ oldContent ifNil: [ repository executeGitCommandOutput: self oldContentCommand ]