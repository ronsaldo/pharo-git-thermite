Class {
	#name : #ThVisCardSourceNodeFunction,
	#superclass : #ThVisCardSourceNode,
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #testing }
ThVisCardSourceNodeFunction >> isFunction [
	^ true
]

{ #category : #testing }
ThVisCardSourceNodeFunction >> isTest [
	^ false
]

{ #category : #accessing }
ThVisCardSourceNodeFunction >> nodeTypeName [
	^ 'Function'
]

{ #category : #asserting }
ThVisCardSourceNodeFunction >> shouldBeTestedForCodeSimilarity [
	^ true
]
