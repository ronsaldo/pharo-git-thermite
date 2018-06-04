visualization
displayEdges: edges forElements: elements
	elements do: [ :element |
		element
			when: TRMouseEnter
			do: [ :e |
				edges do: [ :edge | edge color: self palette movementColor ].
				e signalUpdate ].
		element
			when: TRMouseLeave
			do: [ :e | 
				edges do: [ :edge | edge color: Color transparent ].
				e signalUpdate
			]
	]