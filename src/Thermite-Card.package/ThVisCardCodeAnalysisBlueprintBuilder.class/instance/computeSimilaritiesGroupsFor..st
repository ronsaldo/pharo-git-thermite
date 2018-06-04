as yet unclassified
computeSimilaritiesGroupsFor: changes
	| procesedElements alreadyProcessed group |
	procesedElements := IdentitySet new.
	similarityGroups := OrderedCollection new.
	
	changes allChildrenDo: [ :node |
		node isFalseMovementPositive ifTrue: [
			node hasMovementRefactor: false
		] ifFalse: [ 
		(node hasMovementRefactor and: [ node shouldBeCountedAsMovement ]) ifTrue: [

			alreadyProcessed := false.
			group := Array streamContents: [ :out |
				node allMovementRefactorNodesDo: [ :sn |
					(procesedElements includes: sn) ifTrue: [
						alreadyProcessed := true.
					].
				
					alreadyProcessed ifFalse: [ 
						out nextPut: sn.
						procesedElements add: sn
					].
				]
			].
		
			alreadyProcessed ifFalse: [
				similarityGroups add: group
			]
		]]
	]
