Class {
	#name : #ThGenericCodeTokenStream,
	#superclass : #Object,
	#instVars : [
		'in'
	],
	#category : #'Thermite-Card-CodeAnalysis-Similarity'
}

{ #category : #'instance creation' }
ThGenericCodeTokenStream class >> on: aCollection [ 
	^self new on: aCollection
]

{ #category : #accessing }
ThGenericCodeTokenStream >> isDigit: aCharacter [
	aCharacter ifNil: [ ^ false ].
	^ $0 <= aCharacter and: [ aCharacter <= $9 ]
]

{ #category : #accessing }
ThGenericCodeTokenStream >> isIdentifierMiddle: aCharacter [
	aCharacter ifNil: [ ^ false ].
	^ ($A <= aCharacter and: [ aCharacter <= $Z ]) or: [
		($a <= aCharacter and: [ aCharacter <= $z ]) or: [
		($0 <= aCharacter and: [ aCharacter <= $9 ]) or: [
		$_ = aCharacter]]]

]

{ #category : #accessing }
ThGenericCodeTokenStream >> isIdentifierStart: aCharacter [
	aCharacter ifNil: [ ^ false ].
	^ ($A <= aCharacter and: [ aCharacter <= $Z ]) or: [
		($a <= aCharacter and: [ aCharacter <= $z ]) or: [
		$_ = aCharacter]]

]

{ #category : #accessing }
ThGenericCodeTokenStream >> isSpecial: aCharacter [
	aCharacter ifNil: [ ^ false ].
	aCharacter <= Character space ifTrue: [ ^ false ].
	^ (self isIdentifierMiddle: aCharacter) not
]

{ #category : #accessing }
ThGenericCodeTokenStream >> next [
	| first |
	self skipWhite.
	in atEnd ifTrue: [ ^ nil ].
	
	first := in peek.
	(self isIdentifierStart: first) ifTrue: [ ^ self nextIdentifier ].
	(self isDigit: first) ifTrue: [ ^ self nextNumber ].
	^ self nextSpecial
]

{ #category : #accessing }
ThGenericCodeTokenStream >> nextIdentifier [
	^ ByteString streamContents: [ :out |
		[self isIdentifierMiddle: in peek] whileTrue: [ out nextPut: in next ]
	]
]

{ #category : #accessing }
ThGenericCodeTokenStream >> nextNumber [
	^ ByteString streamContents: [ :out |
		"Whole part"
		[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
		in peek = $. ifTrue: [
			"Fractional part"
			out nextPut: in next.
			[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
		
			"Exponent"
			('eE' includes: in peek) ifTrue: [
				out nextPut: in next.
				('+-' includes: in peek) ifTrue: [
					out nextPut: in next.
				].
			
				[self isDigit: in peek] whileTrue: [ out nextPut: in next ].
			]
		]
	]
]

{ #category : #accessing }
ThGenericCodeTokenStream >> nextSpecial [
	^ ByteString streamContents: [ :out |
		[self isSpecial: in peek] whileTrue: [ out nextPut: in next ]
	]
]

{ #category : #'instance creation' }
ThGenericCodeTokenStream >> on: aCollection [
	in := ReadStream on: aCollection
]

{ #category : #accessing }
ThGenericCodeTokenStream >> skipWhite [
	[in atEnd not and: [in peek <= Character space]] whileTrue: [ in next ]
]
