instance creation
oldSource
	^ oldSource ifNil: [ oldSource := self buildOldSource ]