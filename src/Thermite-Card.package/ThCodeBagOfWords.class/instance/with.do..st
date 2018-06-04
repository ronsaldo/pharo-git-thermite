arithmetic
with: other do: aBlock
	| left right |
	left := self data begin.
	right := other data begin.
	
	[left isNotNil and: [ right isNotNil ]] whileTrue: [ 
		left key < right key ifTrue: [
			aBlock value: left key value: left value value: 0.
			left := left next
		] ifFalse: [
			right key < left key ifTrue: [ 
				aBlock value: right key value: 0 value: right value.
				right := right next
			] ifFalse: [
				aBlock value: left key value: left value value: right value.
				left := left next.
				right := right next
			]
		]
	].

	[ left isNotNil ]	whileTrue: [
		self assert: right isNil.
		aBlock value: left key value: left value value: 0.
		left := left next
	].

	[ right isNotNil ]	whileTrue: [ 
		self assert: left isNil.
		aBlock value: right key value: 0 value: right value.
		right := right next
	].
