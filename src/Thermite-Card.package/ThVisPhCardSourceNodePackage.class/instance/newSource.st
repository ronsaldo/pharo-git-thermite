instance creation
newSource
	^ newSource ifNil: [ newSource := self buildNewSource ]