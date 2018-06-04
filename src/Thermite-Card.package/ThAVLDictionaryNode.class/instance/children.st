accessing
children
	(left isNil and: [ right isNil ]) ifTrue: [ ^ #() ].
	left ifNil: [ ^ { right } ].
	right ifNil: [ ^ { left } ].
	^ { left . right }