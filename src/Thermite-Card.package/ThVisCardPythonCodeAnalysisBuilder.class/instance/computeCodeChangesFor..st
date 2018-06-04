as yet unclassified
computeCodeChangesFor: pullRequest
	| modifications oldProcessor newProcessor |
	modifications := pullRequest modifications.
	oldProcessor := PyProcessor new.
	newProcessor := PyProcessor new.

	pullRequest modifications do: [ :modification |
		modification oldContent ifNotNil: [ 
			oldProcessor processMemoryFileAsString: modification oldContent named: modification filename.
		].
		modification newContent ifNotNil: [ 
			newProcessor processMemoryFileAsString: modification newContent named: modification filename.
		]
	].
	
	^ self computeCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor
