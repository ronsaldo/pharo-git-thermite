initialization
initialize
	LineColors := Dictionary newFromPairs: { 
		$- . {TextColor color: Color red}.
		$+ . {TextColor color: Color green}.
		$@ . {TextColor color: Color blue}.
	}.
	