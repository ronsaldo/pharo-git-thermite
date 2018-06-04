accessing
stringLiteral
	^ (self token: $" asParser , $" asParser negate star flatten, $" asParser) ==> [ :content | content second ]