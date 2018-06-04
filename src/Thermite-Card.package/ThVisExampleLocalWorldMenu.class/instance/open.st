instance creation
open
	Workspace new
	contents: '"DoIt:"
repo := GitStatsRepository path: ''<cloned repository path>''.
commit := repo commit: ''<Commit name or SHA>''.

"Inspect:"
builder := GSCardBuilder new.
builder pythonCodeAnalyzer. "Or pharoCodeAnalyzer"
builder
    addCommit: commit;
    vertical;
    draggable;
    view.
';
	openLabel: 'GitStats example'