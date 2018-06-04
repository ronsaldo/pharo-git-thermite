accessing
title
	| log |
	title ifNil: [
		log := self commitLog lines first.
		title := log allButFirst: (log indexOf: Character space)
	].
	^ title