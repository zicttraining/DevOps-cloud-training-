1. **Install Apache Web Server on Ubuntu**
    **Step 1: Update the System**
        Open a terminal and run the following command to update your package lists:

        ```sudo apt update```
        Step 2: Install Apache
        Install Apache by running the following command:

        ```sudo apt install apache2 -y```
        Step 3: Start and Enable Apache Service
        Start the Apache service using:

        ```sudo systemctl start apache2```
        Enable Apache to start on boot:

        ```sudo systemctl enable apache2```
        Step 4: Verify Apache Installation
        Open a web browser and go to http://<your-server-IP>. You should see the default Apache web page with a message like "Apache2 Ubuntu Default Page".
        2. Create an HTML File with CSS and Navigation Button
        Step 5: Create a Project Directory
        Create a new directory to store your HTML and CSS files in the Apache default root directory (/var/www/html):

        ```sudo mkdir /var/www/html/mywebsite```
        Step 6: Create an HTML File for the Homepage
        Create index.html file in your new project directory:


        ```sudo nano /var/www/html/mywebsite/index.html```
        Add the following HTML code to the index.html file:

        ```
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>My Website</title>
            <link rel="stylesheet" href="styles.css">
        </head>
        <body>
            <h1>Welcome to My Website</h1>
            <h2>Explore More</h2>
            <button onclick="location.href='page2.html';">Next Page</button>
        </body>
        </html>
        ```
        Step 7: Create a CSS File for Styling
        Create a styles.css file in the same project directory:


        ```code /var/www/html/mywebsite/styles.css```
        Add the following CSS code to style the h1 and h2 elements and the button:

        css
        Copy code
        ```
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            text-align: center;
            padding: 50px;
        }

        h1 {
            color: #333;
            font-size: 3em;
        }

        h2 {
            color: #666;
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
        }

        button:hover {
            background-color: #45a049;
        } 
        ```
        Step 8: Create Another HTML Page (Page 2)
        Create a new HTML file page2.html in your project directory:


        ```code /var/www/html/mywebsite/page2.html```
        Add the following HTML code to page2.html:
        ```
        html
        Copy code
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>Page 2 - My Website</title>
            <link rel="stylesheet" href="styles.css">
        </head>
        <body>
            <h1>This is Page 2</h1>
            <h2>Thank you for visiting!</h2>
            <button onclick="location.href='index.html';">Go Back</button>
        </body>
        </html>
        ```
        Step 9: Change Permissions (if needed)
        Ensure Apache has read permissions for the files. If not, set permissions using:

        ```sudo chmod -R 755 /var/www/html/mywebsite```
        Step 10: Restart Apache
        After creating the files, restart Apache to apply changes:

        ```sudo systemctl restart apache2```
        Step 11: Test Your Website
        Open a web browser and visit http://<your-server-IP>/mywebsite/index.html. You should see your homepage with styled h1 and h2 elements and a button. Click the button to navigate to Page 2.