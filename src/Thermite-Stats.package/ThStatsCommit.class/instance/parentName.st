accessing
parentName
	((parent beginsWith: '^') or: [ parent beginsWith: '~' ]) ifTrue: [ ^ name , parent ].
	^ parent