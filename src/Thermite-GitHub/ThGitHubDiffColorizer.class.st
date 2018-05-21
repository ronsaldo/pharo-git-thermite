Class {
	#name : #ThGitHubDiffColorizer,
	#superclass : #Object,
	#classVars : [
		'LineColors'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #'as yet unclassified' }
ThGitHubDiffColorizer class >> colorize: aStringOrText [
	^ self new colorize: aStringOrText
]

{ #category : #initialization }
ThGitHubDiffColorizer class >> initialize [
	LineColors := Dictionary newFromPairs: { 
		$- . {TextColor color: Color red}.
		$+ . {TextColor color: Color green}.
		$@ . {TextColor color: Color blue}.
	}.
	
]

{ #category : #'as yet unclassified' }
ThGitHubDiffColorizer >> colorize: aStringOrText [
	| text char color lastStop runs count |
	text := aStringOrText asText.
	lastStop := 0.
	runs := RunArray new.
	
	self string: aStringOrText linesDo: [ :start  :stop |
		char := aStringOrText at: start.
		color := LineColors at: char ifAbsent: [nil].
		color ifNotNil: [
			count := start - lastStop - 1.
			runs add: #() withOccurrences: count.

			count := stop - start + 1.
			runs add: color withOccurrences: count.

			lastStop := stop.
		]
	].

	runs add: #() withOccurrences: aStringOrText size - runs size.
	self assert: runs size = aStringOrText size.
	text setString: text string setRunsChecking: runs.
	^ text
]

{ #category : #enumerating }
ThGitHubDiffColorizer >> string: aStringOrText linesDo: aBlock [
	| s startPosition c |
	s := ReadStream on: aStringOrText.
	startPosition := 0.
	[s atEnd] whileFalse: [
		c := s next.
		c = Character cr ifTrue: [
			aBlock value: startPosition  + 1 value: s position.
			s peek = Character lf ifTrue: [ s next ].
			startPosition := s position.
		] ifFalse: [ 
			c = Character lf ifTrue: [
				aBlock value: startPosition + 1 value: s position.
				startPosition := s position.
			]
		]
	]
]
