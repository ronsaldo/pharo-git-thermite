Extension { #name : #MCVersionInspector }

{ #category : #'*Thermite-Card' }
MCVersionInspector >> buttonSpecs [
       ^ #((Browse browse 'Browse this version' hasVersion)
               (History history 'Browse the history of this version' hasVersion)
               (Changes changes 'Browse the changes this version would make to the image' hasVersion)
					('Parent changes' parentChanges 'Browse the changes introduced in this version versus its parent' hasVersion)
					('Thermite changes' #thermiteChanges 'View the changes this version would make to the image using Thermite' hasVersion)
					('Thermite parent changes' #thermiteParentChanges 'View the changes that were introduced in this commit' hasVersion)
               (Load load 'Load this version into the image' hasVersion)
               (Merge merge 'Merge this version into the image' hasVersion)
               (Adopt adopt 'Adopt this version as an ancestor of your working copy'
hasVersion)
               (Copy save 'Copy this version to another repository' hasVersion)
               (Diff diff 'Create an equivalent version based on an earlier release'
hasVersion))
]

{ #category : #'*Thermite-Card' }
MCVersionInspector >> parentChanges [
	"Open a patch morph for the changes."
	| oldVersion oldVersionSnapshot newVersionSnapshot ancestor |
	ancestor := self pickAncestor.
	ancestor ifNil: [ ^ self ].
	
	oldVersion := self versionFromVersionInfo: ancestor.
	oldVersionSnapshot := oldVersion completeSnapshot.
	newVersionSnapshot := self version completeSnapshot.
	
	self
		viewChanges: (newVersionSnapshot patchRelativeToBase: oldVersionSnapshot)
		from: oldVersion info name
		to: self version info name
]

{ #category : #'*Thermite-Card' }
MCVersionInspector >> thermiteChanges [
	"Open a patch morph for the changes."
	| newVersionSnapshot oldVersionSnapshot |
	newVersionSnapshot := self version completeSnapshot.
	oldVersionSnapshot := self version completePackageSnapshot.
	
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot
]

{ #category : #'*Thermite-Card' }
MCVersionInspector >> thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot [
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot title: ('Changes from {1} to {2}' format: {self version workingCopy description . self version info name})
]

{ #category : #'*Thermite-Card' }
MCVersionInspector >> thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot title: title [
	"Open a patch morph for the changes."
	| packageName builder analyzer |
	packageName := self version package name.
	
	builder := ThVisCardBuilder new.
	builder withoutUnchangedLines.
	analyzer := builder pharoCodeAnalyzer.
	analyzer allContent;
		withoutUnchangedLines;
		onlyModifiedFunctions ;
		onlyModifiedClasses.
				
	builder
		addMonticelloPackage: packageName
			from: oldVersionSnapshot to: newVersionSnapshot
			title: title;
		vertical;
		inspect

]

{ #category : #'*Thermite-Card' }
MCVersionInspector >> thermiteParentChanges [
	"Open a patch morph for the changes."
	| newVersionSnapshot oldVersionSnapshot oldVersion ancestor |
	ancestor := self pickAncestor.
	ancestor ifNil: [ ^ self ].
	
	oldVersion := self versionFromVersionInfo: ancestor.
	oldVersionSnapshot := oldVersion completeSnapshot.
	newVersionSnapshot := self version completeSnapshot.
	
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot
		title: ('Changes from {1} to {2}' format: {oldVersion info name . self version info name})
]
