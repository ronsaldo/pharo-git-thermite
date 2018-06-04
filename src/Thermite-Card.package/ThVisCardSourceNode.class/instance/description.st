accessing
description
	self wasModified ifFalse: [ 
		^ '{1} {2}' format: {self nodeTypeName . name}
	].

	^ '{1} {2}
	
{3} additions.
{4} deletions.
{5} unchanged lines.
' format: {self nodeTypeName . name . self additions asString . self deletions asString . self unchangedNumberOfLines}