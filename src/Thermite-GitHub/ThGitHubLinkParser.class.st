Class {
	#name : #ThGitHubLinkParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'link',
		'links',
		'space',
		'comma',
		'url',
		'semicolon',
		'attribute',
		'identifier',
		'equal',
		'stringLiteral',
		'identifierStart',
		'identifierContent'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubLinkParser >> attribute [
	^ identifier , equal, stringLiteral ==> [ :result | result first -> result third ]
]

{ #category : #accessing }
ThGitHubLinkParser >> comma [
	^ self token: $, asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> equal [
	^ self token: $= asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> identifier [
	^ self token: (identifierStart, identifierContent star) flatten
]

{ #category : #accessing }
ThGitHubLinkParser >> identifierContent [
	^ #letter asParser / #digit asParser / $_ asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> identifierStart [
	^ #letter asParser / $_ asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> link [
	^ url , (semicolon , attribute) star ==> [ :result |
		{ result first . Dictionary newFrom: (result second collect: #second) } ]
]

{ #category : #accessing }
ThGitHubLinkParser >> links [
	^ link , (comma, link) star ==> [ :result | {result first} , (result second collect: #second) ]
]

{ #category : #accessing }
ThGitHubLinkParser >> semicolon [
	^ self token: $; asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> space [
	^ #space asParser
]

{ #category : #accessing }
ThGitHubLinkParser >> start [
	^ links
]

{ #category : #accessing }
ThGitHubLinkParser >> stringLiteral [
	^ (self token: $" asParser , $" asParser negate star flatten, $" asParser) ==> [ :content | content second ]
]

{ #category : #accessing }
ThGitHubLinkParser >> token: aParser [
	^ aParser trim: space
]

{ #category : #accessing }
ThGitHubLinkParser >> url [
	^ $< asParser, $> asParser negate star flatten, $> asParser ==> [ :result | result second ]
]
