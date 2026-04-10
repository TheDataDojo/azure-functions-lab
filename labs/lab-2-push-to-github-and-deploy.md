# Lab 2: Push to GitHub and Deploy

**Objective:** Commit your local code, push it to a GitHub repository, and deploy it to Azure using GitHub Actions.

**What you will do:**
1. Initialize a Git repository and commit your code.
2. Create a new GitHub repository and push your local code.
3. Review the provided GitHub Actions workflow.
4. Configure the required GitHub secret for Azure authentication.
5. Trigger the workflow and verify the deployment in Azure.

## Steps

### Step 1: Initialize Git and Commit

1. Open the terminal in VS Code.
2. Ensure you are in the root folder of this repository (e.g., `azure-functions-lab`).
3. If not already initialized, run:
   ```bash
   git init
   ```
4. Add all files to the staging area:
   ```bash
   git add .
   ```
5. Commit the changes:
   ```bash
   git commit -m "Initial commit of Azure Functions lab"
   ```

### Step 2: Create a GitHub Repository and Push

1. Go to [GitHub](https://github.com/) and log in.
2. Click the **+** icon in the top right and select **New repository**.
3. Name the repository `azure-functions-lab` (or similar).
4. Leave it Public or Private, and do NOT initialize it with a README, .gitignore, or license.
5. Click **Create repository**.
6. Copy the repository URL (e.g., `https://github.com/YOUR_USERNAME/azure-functions-lab.git`).
7. Back in your VS Code terminal, link your local repository to GitHub:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/azure-functions-lab.git
   ```
8. Push your code to the `main` branch:
   ```bash
   git branch -M main
   git push -u origin main
   ```

### Step 3: Review the GitHub Actions Workflow

1. In VS Code, navigate to `.github/workflows/deploy.yml`.
2. This file defines the automated deployment process. It:
   - Triggers on pushes to the `main` branch.
   - Sets up a Python environment.
   - Installs dependencies from `src/requirements.txt`.
   - Uses the `azure/functions-action` to deploy the code to your Function App.
3. Notice the line `publish-profile: ${{ secrets.AZURE_FUNCTIONAPP_PUBLISH_PROFILE }}`. This is the secret you need to configure in GitHub.

### Step 4: Configure the GitHub Secret

1. Go to the Azure Portal and find the Function App you created in Lab 0.
2. On the Function App's Overview page, click **Get publish profile** at the top. This downloads a `.PublishSettings` file.
3. Open the downloaded file in a text editor and copy its entire contents.
4. Go to your GitHub repository in the browser.
5. Click **Settings** > **Secrets and variables** > **Actions**.
6. Click **New repository secret**.
7. Name the secret exactly: `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`
8. Paste the contents of the publish profile into the **Secret** field.
9. Click **Add secret**.

### Step 5: Trigger the Workflow and Verify

1. Since you already pushed the code, the workflow might have run and failed because the secret was missing.
2. To trigger it again, you can either:
   - Make a small dummy commit and push it.
   - Go to the **Actions** tab in your GitHub repo, select the failed workflow run, and click **Re-run all jobs**.
3. Watch the workflow execute. It should take a few minutes.
4. Once it completes successfully (green checkmark), go to the Azure Portal.
5. Navigate to your Function App and click **Functions** in the left menu.
6. You should see your `HelloWorldHttpTrigger` function listed.
7. Click on it, then click **Get Function Url**.
8. Open that URL in a new browser tab. You should see the same "Hello World" message you saw locally!

## Validation

1. The GitHub Actions workflow completes successfully.
2. The function appears in the Azure Portal.
3. The live Azure Function URL returns the expected response.

## Expected Result

Your Python code is now running live on Azure, automatically deployed from GitHub.
