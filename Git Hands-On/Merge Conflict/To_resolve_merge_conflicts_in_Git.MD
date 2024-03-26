# To resolve merge conflicts in Git, follow these steps:

1. Identify the conflicting files:
   ```
   git status
   ```
2. Open the conflicting file using a text editor:
   ```
    vim filename
   ```
3. Resolve the conflict by choosing which changes to keep and which to discard. The conflicting changes are marked by '<<<' and '>>>>'.

4. Manually edit the file to combine the conflicting changes.

5. Save the file and exit the text editor.

6. Stage the resolved file:
   ```  
   git add filename
   ```
7. Commit the resolved changes:
   ```
   git commit -m "Resolved merge conflict"
   ```
8. Push the changes to the remote repository:
   ```
   git push origin branch-name
   ```