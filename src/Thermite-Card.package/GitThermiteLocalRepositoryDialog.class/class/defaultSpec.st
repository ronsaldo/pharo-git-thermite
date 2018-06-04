initialization
defaultSpec
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
			
			add: #buildVisualizationButton height: self inputTextHeight;
			add: #mcDiffButton height: self inputTextHeight
		];
		yourself