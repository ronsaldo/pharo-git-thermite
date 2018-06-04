accessing
description
	^ '{1}

Additions: {2}
Deletions: {3}
Unchanged Lines: {4}
Border Color: {5}
' format: { self filename . self additions asString. self deletions asString. self unchangedNumberOfLines asString. self tooltipForBorderColor }