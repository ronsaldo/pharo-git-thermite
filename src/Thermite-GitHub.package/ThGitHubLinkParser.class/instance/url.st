accessing
url
	^ $< asParser, $> asParser negate star flatten, $> asParser ==> [ :result | result second ]