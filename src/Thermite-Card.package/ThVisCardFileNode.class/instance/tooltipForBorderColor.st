accessing
tooltipForBorderColor
	^ self isTest ifTrue: [ 'The file could have unit tests.' ] ifFalse: [ 'Normal file.' ]