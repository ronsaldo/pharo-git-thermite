"
A GThGenericCodeTokenStreamTest is a test class for testing the behavior of GThGenericCodeTokenStream
"
Class {
	#name : #ThGenericCodeTokenStreamTest,
	#superclass : #TestCase,
	#category : 'Thermite-Card-Tests'
}

{ #category : #tests }
ThGenericCodeTokenStreamTest >> testTokens [
	| code in |
	code := 'abra 12345 1.3e-29 :.<=>'.
	in := ThGenericCodeTokenStream on: code.
	self assert: in next equals: 'abra'.
	self assert: in next equals: '12345'.
	self assert: in next equals: '1.3e-29'.
	self assert: in next equals: ':.<=>'.
	self assert: in next equals: nil.

]
