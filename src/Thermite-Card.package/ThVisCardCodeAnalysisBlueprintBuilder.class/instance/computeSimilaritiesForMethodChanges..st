as yet unclassified
computeSimilaritiesForMethodChanges: changes
	| removedNodes addedNodes nodesWithHashes previousElement |
	
	removedNodes := OrderedCollection new.
	addedNodes := OrderedCollection new.
	changes allChildrenDo: [ :n |
		n shouldBeTestedForCodeSimilarity ifTrue: [ 
			n wasRemoved ifTrue: [
				removedNodes add: n
			].
			
			n wasAdded ifTrue: [
				addedNodes add: n
			].
		]
	].

	"Check for equality with the help of hashing"
	nodesWithHashes := (removedNodes collect: [ :n | { n oldSource hash . n oldSource . n} ]) ,
		(addedNodes collect: [ :n | { n newSource hash . n newSource. n} ]).
	nodesWithHashes sort: [ :a :b |
		a first = b first ifTrue: [
			a second <= b second
		] ifFalse: [ 
			a first <= b first
		]
	].

	previousElement := nil.
	nodesWithHashes do: [ :element |
		(previousElement isNotNil and: [ previousElement second = element second ]) ifTrue: [
			previousElement third
				hasMovementRefactor: true;
				nextMovementRefactorNode: element third.
				
			element third
				hasMovementRefactor: true;
				previousMovementRefactorNode: previousElement third.
			
		].
		previousElement := element.
	].

	"Build the bag of words"
	"emptyBow := GThCodeBagOfWords empty.
	bowBuilder := GThCodeBagOfWordsBuilder new.
	removedNodes do: [ :n |
		n
			oldSourceBagOfWords: (bowBuilder forString: n oldSource);
			newSourceBagOfWords: emptyBow
	].

	addedNodes do: [ :n |
		n
			oldSourceBagOfWords: emptyBow;
			newSourceBagOfWords: (bowBuilder forString: n newSource)
	]."

	"
	GThCodeBagOfWords matrixForSimilaritiesOf: (nodes collect: #sourceBagOfWords).
	GThCodeBagOfWords formForSimilaritiesOf: (nodes collect: #sourceBagOfWords).
	GThCodeBagOfWords formForSimilaritiesOf: (nodes collect: #sourceBagOfWords) threshold: 0.8.
	"