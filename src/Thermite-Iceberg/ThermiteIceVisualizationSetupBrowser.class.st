Class {
	#name : #ThermiteIceVisualizationSetupBrowser,
	#superclass : #IceTipBrowser,
	#instVars : [
		'targetHistoryPanel',
		'sourceHistoryPanel',
		'languageLabel',
		'language',
		'addUnchangedLines',
		'addUnmodifiedMethods',
		'addUnmodifiedClasses',
		'buildVisualizationButton',
		'addUnmodifiedPackages'
	],
	#category : #'Thermite-Iceberg-Dialogs'
}

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newRow: [ :row |
			row
				newColumn: [ :column |
					column 
						add: #targetHistoryPanel withSpec: #panelSpec left: 0.3;
						addHSplitter;
						add: #sourceHistoryPanel withSpec: #panelSpec left: 0.3
				];
				newColumn: [ :column |
					column newRow: [ :r |
						r add: #languageLabel;
						add: #language
					] height: self inputTextHeight;
					
					add: #addUnchangedLines height: self inputTextHeight;
					add: #addUnmodifiedMethods height: self inputTextHeight;
					add: #addUnmodifiedClasses height: self inputTextHeight;
					add: #addUnmodifiedPackages height: self inputTextHeight;
			
					add: #buildVisualizationButton height: self inputTextHeight
				]
		]

]

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> new [
	self error: 'Use #for:'
]

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> onRepository: aRepository [
	^ self on: (IceTipRepositoryModel on: aRepository)
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> addUnchangedLines [
	^ addUnchangedLines
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> addUnmodifiedClasses [
	^ addUnmodifiedClasses
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> addUnmodifiedMethods [
	^ addUnmodifiedMethods
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> addUnmodifiedPackages [
	^ addUnmodifiedPackages
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> buildVisualization [
	| repo commit builder analyzer |
	sourceHistoryPanel commitInfoTabs selectedModel ifNil: [ ^ self ].
	targetHistoryPanel commitInfoTabs selectedModel ifNil: [ ^ self ].
	
	"repo := ThStatsRepository path: model entity location fullName.
	commit := repo commit: targetHistoryPanel commitInfoTabs selectedModel id parent: sourceHistoryPanel commitInfoTabs selectedModel id."
	repo := ThermiteIceRepository new model: model.
	commit := repo commit: targetHistoryPanel commitInfoTabs selectedModel parent: sourceHistoryPanel commitInfoTabs selectedModel.

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

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> buildVisualizationButton [
	^ buildVisualizationButton
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> contextClass [
	^ IceTipRepositoryContext
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> initializePresenter [
	buildVisualizationButton action: [ self buildVisualization ].
	
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> initializeWidgets [
	super initializeWidgets.	
	
	targetHistoryPanel := self instantiate: IceTipHistoryBrowser on: self model headModel.
	sourceHistoryPanel := self instantiate: IceTipHistoryBrowser on: self model headModel.

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

	self focusOrder 
		add: targetHistoryPanel;
		add: sourceHistoryPanel
		
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> language [
	^ language
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> languageLabel [
	^ languageLabel
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> sourceHistoryPanel [
	^ sourceHistoryPanel
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> targetHistoryPanel [
	^ targetHistoryPanel
]
