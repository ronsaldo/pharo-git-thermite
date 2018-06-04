enumerating
do: aBlock
	self pageDo: aBlock.
	self nextPage ifNotNil: [ :nextPage | nextPage do: aBlock ]