tests
testStress
	| data dict values sorted |
	sorted := (1 to: 10000) collect: #yourself.
	data := sorted copy shuffleBy: (Random seed: 1).
	dict := ThAVLDictionary new.
	data do: [ :e | dict at: e put: e ].
	values := dict collect: #yourself.
	self assert: values equals: sorted