**Here are the steps to clone the repository from GitHub and create a new branch called feature-update:**

**Step 1: Clone the GitHub Repository**

Open your terminal on your Ubuntu server or local machine.
Run the following command to clone the repository:

```git clone https://github.com/vinceinstructor/web-app-2.git```

This will create a local copy of the repository in a directory named web-app-2.

**Step 2: Navigate to the Cloned Repository**

Change into the cloned repository directory:

```cd web-app-2```

**Step 3: Create a New Branch Called feature-update**

Create and switch to the new branch using the following command:


```git checkout -b feature-update```

This command does two things:

Creates a new branch named feature-update.
Switches to the newly created branch.
Verify that you are on the new branch:


```git branch```

You should see a list of branches with an asterisk (*) next to feature-update, indicating you are currently on this branch.

**Step 4: Add a New HTML File in the Branch**
**Create a new HTML file:**

```code form.html```

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Form Page - My Website</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>User Data Submission</h1>
    <form action="#" method="POST">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="message">Message:</label><br>
        <textarea id="message" name="message" rows="5" required></textarea><br><br>

        <button type="submit">Submit</button>
    </form>
    <button onclick="location.href='index.html';">Go Back to Homepage</button>
</body>
</html>
```


```code  new-feature.html```

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Website - Homepage</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Welcome to My Website</h1>
    <h2>Explore More</h2>
    <button onclick="location.href='page2.html';">Next Page</button>
    <button onclick="location.href='form.html';">Submit User Data</button>
</body>
</html>
```


**Update styles.css to Add Form Styling**

**Open styles.css for editing:**

``` code styles.css```

```
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    text-align: center;
    padding: 50px;
}

h1, h2 {
    color: #333;
}

h1 {
    font-size: 3em;
}

h2 {
    font-size: 2em;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 15px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1em;
    margin: 10px;
}

button:hover {
    background-color: #45a049;
}

form {
    display: inline-block;
    text-align: left;
    margin-top: 20px;
    padding: 20px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
}

label {
    display: block;
    margin: 15px 0 5px;
}

input[type="text"], input[type="email"], textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 1em;
}

textarea {
    resize: none;
}

input[type="submit"] {
    background-color: #4CAF50;
    color: white;
    padding: 15px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1em;
    margin-top: 10px;
}

input[type="submit"]:hover {
    background-color: #45a049;
}
```

**Step 5: Add a New HTML File in the Branch**

**git add new file**

``` code git add .```

**git commit new changes**

```git commit -m "Add new feature HTML page"```


**Push the new branch to the remote repository**

```git push -u origin feature-update```


**Step 6: Create a Pull Request on GitHub**

**1. Go to Your Repository on GitHub**

Open a web browser and navigate to the GitHub repository where you pushed the branch.

**2. Switch to the ```feature-update``` Branch**

You should see a message stating that "feature-update branch had recent pushes".
Alternatively, go to the Branches dropdown list and select your newly created branch feature-update.

***3. Click on "Compare & Pull Request"**

GitHub will automatically prompt you to create a pull request if you recently pushed a new branch. Click the **"Compare & pull request"** button.
If you don’t see the prompt, click on the "Pull requests" tab in your repository and then the **"New pull request"** button. Choose the ```feature-update``` branch to compare.

**4. Add a Pull Request Title and Description**

Title: Write a descriptive title, such as "Add new feature page".
Description: Add a detailed description of the changes you made. Explain why these changes are necessary, and what files or features were updated.

**5. Review the Changes**
Scroll down to review the changes you made. GitHub shows a list of commits and a file-by-file comparison, highlighting the added or modified lines.

**6. Assign Reviewers and Labels**

If you are working in a team, you can assign reviewers to the pull request or add labels (such as "feature" or "enhancement") to indicate the type of changes.
This helps team members understand the context of your changes.

**7. Create the Pull Request**

Once everything is reviewed, click the "Create pull request" button. This officially creates the pull request and notifies the repository's maintainers or team members.

**8. Wait for Review and Approval**

After creating the pull request, the maintainers or team members will review your changes. They may leave comments, request modifications, or approve the pull request.

**9. Merge the Pull Request**

Once your pull request is approved, you or a project maintainer can merge it into the target branch ( master).
To merge the pull request:
Click the "Merge pull request" button.
Confirm the merge by clicking "Confirm merge".
