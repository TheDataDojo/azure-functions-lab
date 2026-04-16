# Lab 4: Deploy to an Existing Function App

**Objective:** Learn how to connect Visual Studio Code to an already-provisioned Azure Function App, deploy a new function directly from your local environment, and then set up continuous deployment using GitHub Actions so future changes are deployed automatically.

This lab is ideal if your IT department or a cloud administrator has already created the Azure Function App infrastructure for you, and your job is simply to write and deploy the code.

**What you will do:**
1. Connect VS Code to your Azure subscription and locate the existing Function App.
2. Deploy your local Python function code directly to Azure using the VS Code extension.
3. Verify the function works in the cloud.
4. Set up a GitHub Actions workflow to automate future deployments.
5. Modify the function code, push to GitHub, and watch the automated deployment.

---

## Step 1: Connect VS Code to Azure

1. Open your `src` folder in Visual Studio Code.
2. Click the **Azure** icon in the left Activity Bar (it looks like an 'A').
3. Under the **Resources** section, click **Sign in to Azure...**
4. A browser window will open. Log in with the Azure credentials that have access to the existing Function App.
5. Once signed in, close the browser tab and return to VS Code.
6. In the Azure panel, expand your subscription. You should see a section called **Function App**. Expand it to find your pre-provisioned Function App (e.g., `func-azfunc-xyz`).

---

## Step 2: Deploy Directly from VS Code

For your first deployment, we will push the code directly from your machine to Azure.

1. In the VS Code Azure panel, right-click your existing Function App.
2. Select **Deploy to Function App...** from the context menu.
3. A warning prompt will appear: *"This will overwrite any previous deployment and cannot be undone."* Click **Deploy**.
4. A notification will appear in the bottom right corner showing the deployment progress. You can click **Output Window** to watch the detailed logs.
5. Wait for the notification that says: *"Deployment to 'func-azfunc-xyz' completed."*

---

## Step 3: Verify the Cloud Deployment

1. Still in the Azure panel, expand your Function App, then expand the **Functions** node.
2. You should now see `HelloWorldHttpTrigger` listed under your Function App.
3. Right-click `HelloWorldHttpTrigger` and select **Execute Function Now...**
4. A prompt will ask for a request body. Enter:
   ```json
   { "name": "AzureCloud" }
   ```
5. Press **Enter**.
6. A notification in the bottom right will show the response: *"Hello, AzureCloud. This HTTP triggered function executed successfully."*

You have successfully deployed your local code to an existing Azure Function App!

---

## Step 4: Automate Future Deployments with GitHub Actions

Manually deploying from VS Code is great for testing, but in a real project, you want code to deploy automatically when you push to GitHub.

1. Go to the Azure Portal (https://portal.azure.com) and navigate to your Function App.
2. In the left menu, under **Settings**, click **Configuration** (or **Environment variables** in newer portal versions).
3. Look for a setting called `AZURE_WEB_JOBS_DISABLE_PRIVATE_ENDPOINTS` or similar if your IT department locked it down. For this lab, we just need the deployment credentials.
4. In the left menu, under **Deployment**, click **Deployment Center**.
5. Click the **Settings** tab.
6. For **Source**, select **GitHub**.
7. Authorize Azure to access your GitHub account if prompted.
8. Select your Organization (`BloodliveMSFT`), your Repository (`azure-functions-lab`), and your Branch (`main`).
9. Click **Save** at the top.

*Note: Azure will automatically generate a GitHub Actions workflow file (`.github/workflows/main_func-azfunc-xyz.yml`) and commit it to your repository.*

---

## Step 5: Modify and Auto-Deploy

Now that continuous deployment is set up, let's test it.

1. In VS Code, pull the latest changes from GitHub to get the new workflow file Azure just created:
   ```bash
   git pull origin main
   ```
2. Open `src/function_app.py`.
3. Change the success message on line 20 from:
   `return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")`
   to:
   `return func.HttpResponse(f"Hello, {name}. This function was auto-deployed via GitHub Actions!")`
4. Save the file.
5. Commit and push the change:
   ```bash
   git add src/function_app.py
   git commit -m "Update response message for auto-deploy test"
   git push origin main
   ```
6. Go to your repository on GitHub and click the **Actions** tab.
7. You will see a workflow running for your recent commit. Wait for it to turn green (this usually takes 2-3 minutes).
8. Once complete, return to VS Code, right-click your function in the Azure panel, and select **Execute Function Now...** again with the same JSON body.
9. The response should now say: *"Hello, AzureCloud. This function was auto-deployed via GitHub Actions!"*

---

## Expected Result

You have learned how to take an empty, pre-provisioned Function App, deploy code to it manually for initial testing, and then establish a professional CI/CD pipeline using GitHub Actions for all future updates.
