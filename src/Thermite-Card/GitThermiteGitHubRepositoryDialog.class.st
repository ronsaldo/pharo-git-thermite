Class {
	#name : #GitThermiteGitHubRepositoryDialog,
	#superclass : #ComposableModel,
	#instVars : [
		'projectOwnerLabel',
		'projectOwner',
		'projectNameLabel',
		'projectName',
		'pullRequestNumberLabel',
		'pullRequestNumber',
		'buildVisualizationButton',
		'languageLabel',
		'language',
		'addUnmodifiedClasses',
		'addUnmodifiedMethods',
		'addUnchangedLines',
		'mcDiffButton'
	],
	#category : 'Thermite-Card-Menu'
}

{ #category : #specs }
GitThermiteGitHubRepositoryDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c
			newRow: [ :r |
				r add: #projectOwnerLabel;
					add: #projectOwner
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #projectNameLabel;
					add: #projectName
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #pullRequestNumberLabel;
					add: #pullRequestNumber
			] height: self inputTextHeight;
			newRow: [ :r |
				r add: #languageLabel;
				add: #language
			] height: self inputTextHeight;
			
			add: #addUnchangedLines height: self inputTextHeight;
			add: #addUnmodifiedMethods height: self inputTextHeight;
			add: #addUnmodifiedClasses height: self inputTextHeight;
			
			add: #buildVisualizationButton height: self inputTextHeight;
			add: #mcDiffButton height: self inputTextHeight
		];
		yourself
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> addUnchangedLines [
	^ addUnchangedLines
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> addUnmodifiedClasses [
	^ addUnmodifiedClasses
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> addUnmodifiedMethods [
	^ addUnmodifiedMethods
]

{ #category : #initialization }
GitThermiteGitHubRepositoryDialog >> buildVisualization [
	| session repository pullRequest builder analyzer view |
	session := ThGitHubSession forMainUser.
	
	repository := (session user: projectOwner text repository: projectName text).
	repository cloneRepo.

	pullRequest := repository pullRequestNumber: pullRequestNumber text asInteger.

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

	view := builder
    addPullRequest: pullRequest;
    vertical;
    inspect
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> buildVisualizationButton [
	^ buildVisualizationButton
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> filterUnmodifiedClasses [
	^ addUnmodifiedClasses
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> filterUnmodifiedMethods [
	^ addUnmodifiedMethods
]

{ #category : #initialization }
GitThermiteGitHubRepositoryDialog >> initializePresenter [
	buildVisualizationButton action: [ self buildVisualization ].
	mcDiffButton action: [ self mcDiff ].
	
]

{ #category : #initialization }
GitThermiteGitHubRepositoryDialog >> initializeWidgets [
	self title: 'Visualize GitHub Pull Request'.
	
	projectOwnerLabel := self newLabel.
	projectOwner := self newTextInput.
	projectOwner
		autoAccept: true;
		aboutText: 'Here goes the GitHub project owner name'.
	projectOwnerLabel label: 'GitHub Project Owner:'.
	
	projectNameLabel := self newLabel.
	projectName := self newTextInput.
	projectName autoAccept: true.
	projectNameLabel label: 'GitHub Project Name:'.

	pullRequestNumberLabel := self newLabel.
	pullRequestNumber := self newTextInput.
	pullRequestNumber autoAccept: true.
	pullRequestNumberLabel label: 'GitHub Pull Request Number:'.

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
	
	buildVisualizationButton := self newButton.
	buildVisualizationButton label: 'Build Visualization'.
	
	mcDiffButton := self newButton.
	mcDiffButton label: 'MC Diff'.
	
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> language [
	^ language
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> languageLabel [
	^ languageLabel
]

{ #category : #monticello }
GitThermiteGitHubRepositoryDialog >> mcDiff [
	| session repository pullRequest |
	session := ThGitHubSession forMainUser.
	
	repository := (session user: projectOwner text repository: projectName text).
	repository cloneRepo.

	pullRequest := repository pullRequestNumber: pullRequestNumber text asInteger.
	pullRequest mcDiff
]

{ #category : #monticello }
GitThermiteGitHubRepositoryDialog >> mcDiffButton [
	^ mcDiffButton
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> projectName [
	^ projectName
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> projectNameLabel [
	^ projectNameLabel
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> projectOwner [
	^ projectOwner
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> projectOwnerLabel [
	^ projectOwnerLabel
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> pullRequestNumber [
	^ pullRequestNumber
]

{ #category : #accessing }
GitThermiteGitHubRepositoryDialog >> pullRequestNumberLabel [
	^ pullRequestNumberLabel
]
