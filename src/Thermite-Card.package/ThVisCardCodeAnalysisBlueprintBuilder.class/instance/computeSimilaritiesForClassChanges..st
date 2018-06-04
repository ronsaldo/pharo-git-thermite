as yet unclassified
computeSimilaritiesForClassChanges: changes
	| targetClasses maxTargetClass maxTargetMoveCount movedPercentage |
	changes allChildrenDo: [ :n |
		(n hasMovementRefactor not and: [n isClass and: [n wasAdded or: [n wasRemoved ]]]) ifTrue: [
			targetClasses := IdentityDictionary new.
			n children do: [ :c |
				c hasMovementRefactor ifTrue: [
					c movementRefactorNodesDo: [ :mv |
						(mv parent isClass and: [(n wasAdded and: [ mv wasRemoved ]) or: [ n wasRemoved and: [ mv wasAdded ]]]) ifTrue: [
							targetClasses at: mv parent put: (targetClasses at: mv parent ifAbsent: [0]) + 1
						]
					]
				]
			].
		
			maxTargetClass := nil.
			maxTargetMoveCount := 0.
			targetClasses keysAndValuesDo: [ :class :moveCount |
				moveCount > maxTargetMoveCount ifTrue: [
					maxTargetMoveCount := moveCount.
					maxTargetClass := class
				] 
			].	
		
			movedPercentage := maxTargetMoveCount / (n children size asFloat max: 1).
			movedPercentage > 0.6 ifTrue: [ 
				n hasMovementRefactor: true.
				n connectMovementRefactorWith: maxTargetClass
			]
		]
	]