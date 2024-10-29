Here’s an exercise on using git pull --rebase to resolve a conflict. This will help you practice pulling updates from a remote branch and rebasing your changes to keep a clean commit history.

Exercise: Cloning, Rebasing, and Resolving Conflicts with git pull --rebase
Scenario: You are working on a feature and need to pull the latest updates from the master branch while keeping your branch history clean using a rebase strategy.

**Steps:**

**Step 1: Clone the Repository**
Open your terminal and run the following command to clone the repository:


```git clone https://github.com/vinceinstructor/web-app-2.git```

Navigate into the repository:


```cd web-app-2```

Step 2: Create and Switch to Branch bug_fix



```git checkout -b bug_fix```

Open the index.html file in a text editor and make the following change:

```code index.html```

Add this line inside the <body> tag:
html
Copy code

```<p>Fixed the alignment issue in this version.</p>```

Save the changes, then add and commit them:


```
git add index.html

git commit -m "Fixed alignment issue"

git push
```

**Step 3: Switch to master and Update It**
Switch back to the master branch:


```git checkout master```

<!-- Simulate a teammate’s change: Make a conflicting change in the index.html file:

Modify the same <body> section in index.html to include:
html
Copy code
<p>Updated layout to match new design specifications.</p>
Save the changes, then add and commit them:

bash
Copy code
git add index.html
git commit -m "Updated layout design"
Step 4: Switch Back to bug_fix and Pull the Latest Changes with Rebase
Switch back to your bug_fix branch:



```git checkout bug_fix```

Pull the latest changes from the master branch using rebase: -->

```
git pull --rebase origin master
or
git config  pull.rebase true
```

You will see a conflict message indicating that there is a merge conflict in index.html.

Step 5: Resolve the Conflict During Rebase
Open the index.html file. You should see a conflict similar to this:

html



Step 6: Verify and Push the Changes
Confirm that the rebase was successful:

merge the changes from bug_fic brach into master 

```git merge bug_fix```

```
git log --oneline --graph
```
Push the rebased changes (if you have push access):


```git push ```