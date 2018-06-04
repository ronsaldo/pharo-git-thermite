accessing
links
	^ link , (comma, link) star ==> [ :result | {result first} , (result second collect: #second) ]