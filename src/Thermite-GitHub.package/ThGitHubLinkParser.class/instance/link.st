accessing
link
	^ url , (semicolon , attribute) star ==> [ :result |
		{ result first . Dictionary newFrom: (result second collect: #second) } ]