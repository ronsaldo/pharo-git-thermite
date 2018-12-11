Class {
	#name : #GitThermiteLocalRepositoryDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'localRepositoryPath',
		'commitSha',
		'localRepositoryPathLabel',
		'commitShaLabel',
		'localRepositoryPathBrowseButton',
		'buildVisualizationButton',
		'languageLabel',
		'language',
		'addUnmodifiedClasses',
		'addUnmodifiedMethods',
		'addUnchangedLines',
		'parentCommitShaLabel',
		'parentCommitSha',
		'mcDiffButton',
		'addUnmodifiedPackages'
	],
	#category : #'Thermite-Card-Menu'
}

{ #category : #initialization }
GitThermiteLocalRepositoryDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c
			newRow: [ :r |
				r add: #localRepositoryPathLabel;
					add: #localRepositoryPath;
					add: #localRepositoryPathBrowseButton width: 40
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #commitShaLabel;
				add: #commitSha
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #parentCommitShaLabel;
				add: #parentCommitSha
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #languageLabel;
				add: #language
			] height: self inputTextHeight;
			add: #addUnchangedLines height: self inputTextHeight;
			add: #addUnmodifiedMethods height: self inputTextHeight;
			add: #addUnmodifiedClasses height: self inputTextHeight;
			add: #addUnmodifiedPackages height: self inputTextHeight;
			
			add: #buildVisualizationButton height: self inputTextHeight;
			add: #mcDiffButton height: self inputTextHeight
		];
		yourself
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> addUnchangedLines [
	^ addUnchangedLines
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> addUnmodifiedClasses [
	^ addUnmodifiedClasses
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> addUnmodifiedMethods [
	^ addUnmodifiedMethods
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> addUnmodifiedPackages [
	^ addUnmodifiedPackages
]

{ #category : #initialization }
GitThermiteLocalRepositoryDialog >> browseLocalRepository [
	| localRepoPath |
	localRepoPath := UIManager default chooseDirectory: 'Local Git Repository Folder'.
	localRepoPath ifNil: [ ^ self ].
	localRepositoryPath text: localRepoPath fullName.
]

{ #category : #initialization }
GitThermiteLocalRepositoryDialog >> buildVisualization [
	| repo commit builder analyzer |
	repo := ThStatsRepository path: localRepositoryPath text.
	commit := repo commit: commitSha text parent: parentCommitSha text.

	builder := ThVisCardBuilder new.
	analyzer := builder codeAnalyzer: language selectedItem new.
	
	analyzer allContent.
	addUnchangedLines state ifFalse: [
		builder withoutUnchangedLines.
		analyzer withoutUnchangedLines
	].

	addUnmodifiedMethods state ifFalse: [
		analyzer onlyModifiedFunctions.
	].
	
	addUnmodifiedClasses state ifFalse: [ 
		analyzer onlyModifiedClasses.
	].

	addUnmodifiedPackages state ifFalse: [ 
		analyzer onlyModifiedPackages.
	].

	builder
    addCommit: commit;
    vertical;
    inspect
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> buildVisualizationButton [
	^ buildVisualizationButton
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> commitSha [
	^ commitSha
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> commitShaLabel [
	^ commitShaLabel
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> initialExtent [
	^ 400@330
]

{ #category : #initialization }
GitThermiteLocalRepositoryDialog >> initializePresenter [
	localRepositoryPathBrowseButton action: [ self browseLocalRepository ].
	buildVisualizationButton action: [ self buildVisualization ].
	mcDiffButton action: [ self mcDiff ]
	
]

{ #category : #initialization }
GitThermiteLocalRepositoryDialog >> initializeWidgets [
	self title: 'Visualize Local Commit'.
	
	localRepositoryPathLabel := self newLabel.
	localRepositoryPath := self newTextInput.
	localRepositoryPath autoAccept: true.
	localRepositoryPathBrowseButton := self newButton.
	localRepositoryPathLabel label: 'Local Repository Path:'.
	localRepositoryPathBrowseButton label: '...'.
	
	commitShaLabel := self newLabel.
	commitSha := self newTextInput.
	commitSha autoAccept: true; text: 'master'.
	commitShaLabel label: 'Commit Name:'.

	parentCommitShaLabel := self newLabel.
	parentCommitSha := self newTextInput.
	parentCommitSha autoAccept: true; text: '~1'.
	parentCommitShaLabel label: 'Parent Commit Name'.

	languageLabel := self newLabel.
	language := self newDropList.
	languageLabel label: 'Language:'.
	language
		items: ThVisCardCodeAnalysisBlueprintBuilder allSubclasses;
		displayBlock: [ :b | b languageName ].
	
	addUnchangedLines := self newCheckBox.
	addUnchangedLines label: 'Add unchanged lines'.
	
	addUnmodifiedMethods := self newCheckBox.
	addUnmodifiedMethods label: 'Add unchanged methods'.
	
	addUnmodifiedClasses := self newCheckBox.
	addUnmodifiedClasses label: 'Add unchanged classes'.
	
	addUnmodifiedPackages := self newCheckBox.
	addUnmodifiedPackages label: 'Add unchanged packages'.

	buildVisualizationButton := self newButton.
	buildVisualizationButton label: 'Build Visualization'.
	
	mcDiffButton := self newButton.
	mcDiffButton label: 'MC Diff'.
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> language [
	^ language
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> languageLabel [
	^ languageLabel
]

{ #category : #'as yet unclassified' }
GitThermiteLocalRepositoryDialog >> localRepositoryPath [
	^ localRepositoryPath
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> localRepositoryPathBrowseButton [
	^ localRepositoryPathBrowseButton
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> localRepositoryPathLabel [
	^ localRepositoryPathLabel
]

{ #category : #initialization }
GitThermiteLocalRepositoryDialog >> mcDiff [
	| repo commit |
	repo := ThStatsRepository path: localRepositoryPath text.
	commit := repo commit: commitSha text parent: parentCommitSha text.
	commit mcDiff
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> mcDiffButton [
	^ mcDiffButton
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> parentCommitSha [
	^ parentCommitSha
]

{ #category : #accessing }
GitThermiteLocalRepositoryDialog >> parentCommitShaLabel [
	^ parentCommitShaLabel
]
