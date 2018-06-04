as yet unclassified
filterModifiedFiles: files
	^ files reject: [ :file | file filename includesSubstring: '.package' ]