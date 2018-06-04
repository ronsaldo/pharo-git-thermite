modifications
doFindModifications
	| filenames repo oldContents newContents |
	filenames := self modifiedFilenames.
	
	repo := self repository.
	self checkoutParent.
	
	oldContents := filenames collect: [ :filename | repo getFileContent: filename ifAbsent: [nil]].
	
	self fetch; checkout.
	newContents := filenames collect: [ :filename | repo getFileContent: filename ifAbsent: [nil]].
	^ (filenames collectWithIndex: [ :filename :index |
		ThGitHubFileDifference new
			filename: filename;
			oldContent: (oldContents at: index);
			newContent: (newContents at: index);
			yourself
	]) select: #isValid