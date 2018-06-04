as yet unclassified
findModifiedPackagesIn: pullRequest
	| re range filetreeRepository packageName result ranges |
	re := '[^/\\]+\.package' asRegex.
	result := Dictionary new.
	pullRequest modifiedFilenames do: [ :filename |
		ranges := (re matchingRangesIn: filename).
		ranges ifNotEmpty: [
			range := ranges last.
			filetreeRepository := filename first: range first - 1.
			packageName := filename copyFrom: range first to: range last.
			result at: filetreeRepository , packageName put: { packageName . filetreeRepository } 
		]
	].
	^ result
