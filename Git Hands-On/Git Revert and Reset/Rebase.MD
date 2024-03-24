# Rebase ###

## Prepare for a rebase by checking out the branch you want to rebase.
Start the rebase process with the following command:
```
git rebase <base-branch>
```
For example, if you want to rebase the feature branch onto the main branch:
```
git rebase main
```
## If you encounter conflicts, resolve them and continue the rebase with:
```
git rebase --continue
```

## If you want to abort the rebase, use:
```
git rebase --abort
```
## After the rebase is complete, push the changes to the remote repository (if necessary):
```
git push -f origin <branch-name>
```

### Revert ###


## Generate a new commit that undoes the changes made by the previous commits:
```
git revert <commit-id>
```
## If you want to revert multiple commits, use:
```
git revert <commit-id1> <commit-id2> ...
```

## Push the revert changes to the remote repository:
```
git push origin <branch-name>
```

## Undoing a Rebase in Remote Repositories
1.Create a backup of your local repository.
2.Check the reflog to find the original commit before the rebase:
```
 git reflog
```

## Reset the branch to the original commit:
```
git reset --hard <original-commit-id>
```

## Force-push the changes to the remote repository:
```
git push -f origin <branch-name>
```




























