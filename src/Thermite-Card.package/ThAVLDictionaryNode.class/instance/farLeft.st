as yet unclassified
farLeft
	| position |
	position := self.
	[position left ~~ nil] whileTrue: [
		position := position left
	].
	^ position