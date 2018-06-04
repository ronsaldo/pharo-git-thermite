adding
addPackages: packages to: root
	packages do: [ :package | self addPackage: package to: root ]