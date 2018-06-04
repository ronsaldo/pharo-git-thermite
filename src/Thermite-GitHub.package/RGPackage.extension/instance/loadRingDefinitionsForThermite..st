*Thermite-GitHub
loadRingDefinitionsForThermite: ringDefinitions
	| methodClass |
	ringDefinitions reject: #isOrganization thenDo: [ :element |
		(element isTrait and: [ element isMeta ]) ifFalse: [ 
			self addElement: element
		]
	].

	self methodsDo: [ :method |
		methodClass := self lookupClassNamed: method className.
		methodClass ifNotNil: [ methodClass addMethod: method ]
	].
