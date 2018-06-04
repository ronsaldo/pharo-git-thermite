enumerating
do: aBlock
	| position |
	position := self begin.
	[ position ~~ nil ] whileTrue: [
		aBlock value: position.
		position := position next
	]