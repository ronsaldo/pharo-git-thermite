specs
defaultSpec
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