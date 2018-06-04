monticello
loadOldAndNewMonticelloPackageSnapshots
	| packages oldVersion newVersion |
	packages := self findModifiedMonticelloPackages.
	self checkoutParent.
	oldVersion := self loadMonticelloPackageSnapshots: packages.
	self checkout.
	newVersion := self loadMonticelloPackageSnapshots: packages.
	
	^ {oldVersion . newVersion}
