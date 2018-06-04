monticello
loadOldAndNewMonticelloPackages
	| packages oldVersion newVersion |
	packages := self findModifiedMonticelloPackages.
	self checkoutParent.
	oldVersion := self loadMonticelloPackages: packages.
	self checkout.
	newVersion := self loadMonticelloPackages: packages.
	
	^ {oldVersion . newVersion}
