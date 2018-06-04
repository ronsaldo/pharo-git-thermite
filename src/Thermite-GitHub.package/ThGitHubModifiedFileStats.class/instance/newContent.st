accessing
newContent
	^ newContent ifNil: [ repository executeGitCommandOutput: self newContentCommand ]