# Lab 4: Modify and Redeploy

**Objective:** Open your project in VS Code, modify the existing function code, and redeploy the update to Azure.

This lab demonstrates the update lifecycle. Just like in Lab 2, you can deploy your update either directly from VS Code OR by pushing your changes to GitHub to trigger an automated CI/CD pipeline.

---

## Step 1: Open the Project and Modify the Code

1. Open Visual Studio Code.
2. Go to **File > Open Folder...** and select the `src` folder of your project (or the root `azure-functions-lab` folder).
3. In the Explorer pane on the left, click on `function_app.py` to open it.
4. Locate the line that returns the default "Hello World" success message. It should look like this:
   ```python
   return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
   ```
5. Change the message to something new. For example:
   ```python
   return func.HttpResponse(f"Welcome back, {name}! Your Azure Function has been successfully updated.")
   ```
6. Save the file (`Ctrl+S` or `Cmd+S`).

---

## Step 2: Redeploy the Update

Choose **one** of the following methods to push your update to Azure.

### Path A: Redeploy Directly from VS Code (Without GitHub)
*Use this path if you want to push the update immediately from your machine.*

1. Click the **Azure** icon in the left Activity Bar.
2. Under the **Workspace** section, click the **Deploy** button (a cloud icon with an up arrow).
3. Select **Deploy to Function App...**
4. Select your existing Function App from the list.
5. Click **Deploy** when prompted to overwrite the previous deployment.
6. Wait for the notification in the bottom right corner confirming the deployment is complete.

### Path B: Redeploy via GitHub Actions (CI/CD)
*Use this path if you set up GitHub Actions in Lab 2. This is the recommended workflow for production.*

1. Open the integrated terminal in VS Code (`Ctrl + \``).
2. Ensure you are in the root folder of your repository.
3. Add your changed file to the staging area:
   ```bash
   git add src/function_app.py
   ```
4. Commit the change with a descriptive message:
   ```bash
   git commit -m "Update greeting message in HTTP trigger"
   ```
5. Push the commit to GitHub:
   ```bash
   git push origin main
   ```
6. Go to your repository on [GitHub](https://github.com/).
7. Click the **Actions** tab. You should see a new workflow run triggered by your push.
8. Wait for the workflow to complete successfully (green checkmark).

---

## Validation

1. Go to the Azure Portal.
2. Navigate to your Function App and click **Functions** in the left menu.
3. Click on your `HelloWorldHttpTrigger` function, then click **Get Function Url**.
4. Open that URL in a new browser tab and add `?name=Cloud` to the end.
5. You should see your **new, updated message** returned by the live Azure Function!

## Expected Result

You have successfully modified an existing Azure Function and redeployed the update to the cloud, proving that your deployment pipeline (whether manual or automated) is working correctly for future iterations.
