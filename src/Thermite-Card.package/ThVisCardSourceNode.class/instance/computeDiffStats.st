accessing
computeDiffStats
	| diffBuilder |
	unchangedNumberOfLines := 0.
	additions := 0.
	deletions := 0.
	diffBuilder := TextDiffBuilder from: self oldSource to: self newSource.
	diffBuilder patchSequenceDoIfMatch: [ :string | unchangedNumberOfLines := unchangedNumberOfLines + 1]
		ifInsert: [ :string | additions := additions + 1]
		ifRemove: [ :string | deletions := deletions + 1]
