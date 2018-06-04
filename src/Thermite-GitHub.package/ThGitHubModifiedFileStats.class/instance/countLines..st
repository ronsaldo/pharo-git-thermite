ui
countLines: aString
	"Method taken from CompiledMethod >>linesOfCode."
	
	"An approximate measure of lines of code.
	Includes comments, but excludes empty lines."
	| lines |
	lines := 0.
	aString lineIndicesDo: [:start :endWithoutDelimiters :end |
		endWithoutDelimiters > start ifTrue: [lines := lines+1]].
	^ lines