*Thermite-GitHub
asRingPackageNamedForThermite: ringPackageName
	| ringPackage |
	ringPackage := RGPackage named: ringPackageName.
	ringPackage loadRingDefinitionsForThermite: (self definitions collect: #asRingDefinition).
	^ ringPackage