commit tree view
buildCommitTreeViewFor: visitCard
	| b commitDictionary displayedLinesSum commitSize normalizationFactor |
	b := self newMondrianBuilder.

	commitDictionary := Dictionary new..
	visitCard commits do: [ :commit | commitDictionary at: commit sha put: commit].
	
	b interaction
		popupText: [:commit | self tooltipForCommit: commit ]
		solidBackgroundColor: self palette popupBackgroundColor.

	b shape box
		width: [:commit | commit deletions];
		height: [:commit | commit additions].
	b nodes: visitCard commits forEach: [ :commit |
		displayedLinesSum := commit additions + commit deletions.
		commitSize := displayedLinesSum sqrt*0.1.
		normalizationFactor := commitSize * FileChartWidth / (displayedLinesSum max: 1).
		b shape box
			color: #second;
			width: FileChartWidth;
			height: #third.
		b interaction
			popupText: [:el | self tooltipForCommit: commit ] solidBackgroundColor: self palette popupBackgroundColor;
			when: TRMouseLeftClick do: [ :event | commit inspect ].
		
		b nodes: ({
			{commit additions asString , ' additions' . self palette additionsColor . commit additions* normalizationFactor}.
			{commit deletions asString , ' deletions' . self palette deletionsColor . commit deletions*normalizationFactor}
		} select: [:el | el third ~= 0]).
		b layout verticalLine verticalGap: 0.
	].
	
	b edges connectToAll: [ :commit |
		commit parentsSha
			collect: [ :parentSha | commitDictionary at: parentSha ifAbsent: [ nil ] ]
			thenReject: #isNil
	].
	"b nodes: (1 to: 3).
	b edges connectToAll: [ :v | { v + 1 . v + 2 } ].
	"
	"b layout circle radius: 10."
	b layout tree.
	b build.

	^ b view