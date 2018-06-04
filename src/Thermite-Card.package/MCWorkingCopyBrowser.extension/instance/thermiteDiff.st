*Thermite-Card
thermiteDiff
	"View the changes made in the working copy."
	
	| workingVersion repositoryVersion builder analyzer |
	'Finding changes' displayProgressFrom: 0 to: 10 during:[:bar|
		self canSave ifTrue:[
			bar current: 1.
			workingVersion := workingCopy completeSnapshot.
			bar current: 2.
			repositoryVersion := workingCopy closestAncestorSnapshotIn: self repository.
			bar current: 3.
	
			builder := ThVisCardBuilder new.
			builder withoutUnchangedLines.
			analyzer := builder pharoCodeAnalyzer.
			analyzer allContent;
				withoutUnchangedLines;
				onlyModifiedFunctions;
				onlyModifiedClasses.
				
			builder
				addMonticelloPackage: workingCopy packageName
					from: repositoryVersion to: workingVersion
					title: 'Changes introduced in current image';
				vertical;
				inspect
		]
	]