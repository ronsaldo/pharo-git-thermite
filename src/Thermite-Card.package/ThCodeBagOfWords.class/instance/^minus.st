arithmetic
- other
	| result |
	result := self class new.
	self with: other do: [ :i :a :b |
		result data at: i put: a - b
	].
	^ result
