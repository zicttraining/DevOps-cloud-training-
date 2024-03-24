# Merge

## To merge changes from one branch into another:
Check out the branch you want to merge the changes into.
Run the following command:
```
git merge <branch-name>
```
## For example, to merge changes from a branch named "feature" into the current branch:
```
git merge feature
```

## Commit the merge:
 ```
bash
git commit
```

### Rebase ###

## Check out the branch you want to rebase.
Start the rebase process with the following command:
```
git rebase <base-branch>
```

## For example, to rebase the current branch onto the "main" branch:
```
git rebase main
```

## If there are any conflicts, resolve them and continue the rebase with:
```
git rebase --continue
```

## If you encounter issues and want to abort the rebase, use:
```
git rebase --abort
```

## After the rebase is complete, you may need to force-push the changes to the remote repository
```
git push -f origin <branch-name>
```






































