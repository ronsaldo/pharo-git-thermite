Class {
	#name : #ThermiteIceVisualizeWorkingCopyCommand,
	#superclass : #ThermiteIceCommand,
	#category : #'Thermite-Iceberg-Commander'
}

{ #category : #accessing }
ThermiteIceVisualizeWorkingCopyCommand class >> defaultHelp [
	^ 'Visualize local changes with Thermite.'
]

{ #category : #accessing }
ThermiteIceVisualizeWorkingCopyCommand class >> defaultMenuIconName [
	^ #glamorousSearch
]

{ #category : #accessing }
ThermiteIceVisualizeWorkingCopyCommand class >> defaultMenuItemName [
	^ 'Thermite'
]

{ #category : #accessing }
ThermiteIceVisualizeWorkingCopyCommand class >> toolbarCommitActivation [
	<classAnnotation>
	
	^ IceTipToolbarActivation byRootGroupItemFor: IceTipCommitContext
]

{ #category : #execution }
ThermiteIceVisualizeWorkingCopyCommand >> execute [
	| repoModel repo workingCopy commit builder analyzer |
	repoModel := self repositoryModel.
	
	repo := ThermiteIceRepository new model: repoModel.
	workingCopy := ThermiteIceWorkingCopyModel new
		comment: ('Commit on {1} branch {2}' format: {
			repoModel name .
			repoModel branchName
		});
		workingCopy: repoModel entity workingCopy.
	commit := repo commit: workingCopy parent: repoModel headModel.

	builder := ThVisCardBuilder new.
	analyzer := builder pharoCodeAnalyzer .

	builder
		withoutUnchangedLines.
	
	analyzer
		allContent;
		withoutUnchangedLines;
		onlyModifiedFunctions;
		onlyModifiedClasses;
		onlyModifiedPackages.

	builder
    addCommit: commit;
    vertical;
    inspect
]
