instance creation
open
	Workspace new
	contents: '"
A GitHub access token has to be generated for using this tool.
The access token can be generated in GitHub by going to:
Settings -> Developer settings -> Personal access tokens.

IMPORTANT: Be sure to save the access token in a safe place.
Once the access token is generated, and it is displayed in GitHub,
it cannot be seen again.
"

"DoIt:"
session := GitHubSession  new
    username: ''<user>''; token: ''<github api access token>''.
   
repository := (session user: ''numpy'' repository: ''numpy'').
repository cloneRepo.

pullRequest := repository pullRequestNumber: 8898.

"Inspect:"
builder := GSCardBuilder new.
builder
    pythonCodeAnalyzer;
    addPullRequest: pullRequest;
    vertical;
    draggable;
    view.
';
	openLabel: 'GitStats example'