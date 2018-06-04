accessing
addMonticelloPackage: packageName from: oldVersion to: newVersion title: aTitle
	| oldVersionRingPackage newVersionRingPackage fakeCommit |
	oldVersionRingPackage := oldVersion asRingPackageNamedForThermite: packageName.
	newVersionRingPackage := newVersion asRingPackageNamedForThermite: packageName.
	fakeCommit := ThStatsMonticelloDiff new
		title: aTitle;
		oldPackages: { oldVersionRingPackage };
		newPackages: { newVersionRingPackage };
		yourself.
	self addCommit: fakeCommit.