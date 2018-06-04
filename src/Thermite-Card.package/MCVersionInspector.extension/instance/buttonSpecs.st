*Thermite-Card
buttonSpecs
       ^ #((Browse browse 'Browse this version' hasVersion)
               (History history 'Browse the history of this version' hasVersion)
               (Changes changes 'Browse the changes this version would make to the image' hasVersion)
					('Parent changes' parentChanges 'Browse the changes introduced in this version versus its parent' hasVersion)
					('Thermite changes' #thermiteChanges 'View the changes this version would make to the image using Thermite' hasVersion)
					('Thermite parent changes' #thermiteParentChanges 'View the changes that were introduced in this commit' hasVersion)
               (Load load 'Load this version into the image' hasVersion)
               (Merge merge 'Merge this version into the image' hasVersion)
               (Adopt adopt 'Adopt this version as an ancestor of your working copy'
hasVersion)
               (Copy save 'Copy this version to another repository' hasVersion)
               (Diff diff 'Create an equivalent version based on an earlier release'
hasVersion))