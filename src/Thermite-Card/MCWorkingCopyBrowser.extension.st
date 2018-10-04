Extension { #name : #MCWorkingCopyBrowser }

{ #category : #'*Thermite-Card' }
MCWorkingCopyBrowser >> buttonSpecs [
	^ #(#('+Package' #addWorkingCopy 'Add a new package and make it the working copy')
		#('+Config' #addMetacelloConfiguration 'Add a new metacello configuration')
		#('+Slice' #addSlice 'Add a slice to cleaning and nicely propose a bug fix')
		#('Browse' #browseWorkingCopy 'Browse the working copy of the selected package' #hasWorkingCopy)
		#('Changes' #viewChanges 'View the working copy''s changes relative to the installed version from the repository' #canSave)
		#('Thermite Changes' #thermiteDiff 'View the working copy''s changes relative to the installed version from the repository' #canSave)
	 	#('+Repository' #addRepository 'Add an existing repository to the list of those visible')
		#('Save' #saveVersion 'Save the working copy as a new version to the selected repository' #canSave)
		#('Open' #openRepository 'Open a browser on the selected repository' #hasRepository))
]

{ #category : #'*Thermite-Card' }
MCWorkingCopyBrowser >> thermiteDiff [
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
]
