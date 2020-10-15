# Rebase after fork
Imagine you forked a project, added features and now want to create a pull request to merge your repo into the original repo. But the original repo has made some changes in the meanwhile.
Then you need to rebase.

In your fork:
```
git remote add upstream {url from the orinal project}
#Note that upstream is just a name like origin. You can view this with: git remote show

#rebase
git fetch upstream master
git rebase upstream/master
git push origin
#now you can create a PR
```
