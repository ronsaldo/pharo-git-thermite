as yet unclassified
buildFileChangesChartFor: pullRequest
	| files addedFiles removedFiles modifiedFiles unchangedFiles counted |
	files := codeAnalyzer filterModifiedFiles: (pullRequest numStat collect: [:rf |
		ThVisCardFileNode new
			palette: self palette;
			model: rf]).
	files ifEmpty: [ ^ #() ].
	
	self addNavigation: 'File Changes' view: [self buildCommitFileChangesFor: pullRequest files: files] priority: -10.
	
	addedFiles := OrderedCollection new.
	removedFiles := OrderedCollection new.
	modifiedFiles := OrderedCollection new.
	unchangedFiles := OrderedCollection new.
	
	files do: [ :file |
		counted := false.
		file wasAdded ifTrue: [ addedFiles add: file . counted := true ].
		file wasRemoved ifTrue: [ removedFiles add: file . counted := true ].
		file wasModified ifTrue: [ modifiedFiles add: file . counted := true ].
		counted ifFalse: [ unchangedFiles add: file ].
	].

	^ {
		self plotMetrics: {
			{ self palette additionsColor . '{1} - Added files' . addedFiles size . [self buildCommitFileChangesFor: pullRequest files: addedFiles] }.
			{ self palette deletionsColor . '{1} - Removed files' . removedFiles size . [self buildCommitFileChangesFor: pullRequest files: removedFiles] }.
			"{ self palette movementColor . '{1} - Moved classes' . movedClasses size . self visualizationForClasses: movedClasses }."
			{ self palette modifiedColor . '{1} - Modified files' . modifiedFiles size . [self buildCommitFileChangesFor: pullRequest files: modifiedFiles] }.
			withoutUnchangedLines ifFalse: [
				{ self palette unchangedColor . '{1} - Unchanged files ' . unchangedFiles size . [self buildCommitFileChangesFor: pullRequest files: unchangedFiles] }
			]
		} title: 'Files'
	}