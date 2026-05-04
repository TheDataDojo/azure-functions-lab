# Lab 2: Push to GitHub and Deploy

**Objective:** Commit your local code, push it to a GitHub repository, and set up continuous deployment (CI/CD) to Azure.

You can set up CI/CD using either the **Azure Portal Deployment Center** (automated setup) OR by configuring the **GitHub Actions workflow manually** (best for learning how it works under the hood). Choose one path below.

**What you will do:**
1. Initialize a Git repository and push your code to GitHub.
2. Set up GitHub Actions CI/CD using either Deployment Center or Manual Configuration.
3. Trigger the workflow and verify the deployment in Azure.

---

## Step 1: Initialize Git and Push to GitHub

Regardless of which CI/CD path you choose, your code must be in GitHub first.

1. Open the terminal in VS Code.
2. Ensure you are in the root folder of this repository (e.g., `azure-functions-lab`).
3. If not already initialized, run:
   ```bash
   git init
   ```
4. Add all files to the staging area and commit:
   ```bash
   git add .
   git commit -m "Initial commit of Azure Functions lab"
   ```
5. Go to [GitHub](https://github.com/) and log in.
6. Click the **+** icon in the top right and select **New repository**.
7. Name the repository `azure-functions-lab` (or similar). Leave it Public or Private, and **do NOT** initialize it with a README or .gitignore.
8. Click **Create repository**.
9. Copy the repository URL (e.g., `https://github.com/YOUR_USERNAME/azure-functions-lab.git`).
10. Back in your VS Code terminal, link your local repository to GitHub and push:
    ```bash
    git remote add origin https://github.com/YOUR_USERNAME/azure-functions-lab.git
    git branch -M main
    git push -u origin main
    ```

---

## Path A: Set up CI/CD via Azure Deployment Center

The Deployment Center is the easiest way to connect Azure to GitHub. It automatically generates a workflow file and configures the necessary secrets for you.

### Step A1: Connect Azure to GitHub
1. Go to the Azure Portal and find the Function App you created in Lab 0.
2. In the left menu, under **Deployment**, click **Deployment Center**.
3. On the **Settings** tab, set the **Source** dropdown to **GitHub**.
4. If prompted, click **Authorize** to allow Azure to access your GitHub account.
5. Fill in the repository details:
   - **Organization:** Select your GitHub username or organization.
   - **Repository:** Select the `azure-functions-lab` repository you just created.
   - **Branch:** Select `main`.
6. Click **Save** at the top of the screen.

### Step A2: Sync Local Code
Azure just committed a brand new GitHub Actions workflow file directly to your GitHub repository. You need to pull it down to your local machine before you make any future changes.
1. In your VS Code terminal, run:
   ```bash
   git pull origin main
   ```
2. Proceed to the **Validation** section below.

---

## Path B: Set up CI/CD Manually (Learn the Mechanics)

If you prefer to understand exactly how the authentication works, you can use the pre-built workflow file provided in this repository and configure the secret manually.

### Step B1: Review the GitHub Actions Workflow
1. In VS Code, navigate to `.github/workflows/deploy.yml`.
2. This file defines the automated deployment process. It:
   - Triggers on pushes to the `main` branch.
   - Sets up a Python environment and installs dependencies.
   - Uses the `azure/functions-action` to deploy the code.
3. Notice the line `publish-profile: ${{ secrets.AZURE_FUNCTIONAPP_PUBLISH_PROFILE }}`. This is the secret you need to configure in GitHub.

### Step B2: Configure the GitHub Secret
1. Go to the Azure Portal and find your Function App.
2. On the Function App's Overview page, click **Get publish profile** at the top. This downloads a `.PublishSettings` file.
3. Open the downloaded file in a text editor and copy its entire contents.
4. Go to your GitHub repository in the browser.
5. Click **Settings** > **Secrets and variables** > **Actions**.
6. Click **New repository secret**.
7. Name the secret exactly: `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`
8. Paste the contents of the publish profile into the **Secret** field and click **Add secret**.

### Step B3: Trigger the Workflow
1. Since you already pushed the code in Step 1, the workflow might have run and failed because the secret was missing.
2. To trigger it again, go to the **Actions** tab in your GitHub repo, select the failed workflow run, and click **Re-run all jobs**. Proceed to the **Validation** section below.

---

## Validation

1. Go to the **Actions** tab in your GitHub repository.
2. Watch the workflow execute. It should take a few minutes.
3. Once it completes successfully (green checkmark), go to the Azure Portal.
4. Navigate to your Function App and click **Functions** in the left menu.
5. You should see your `HelloWorldHttpTrigger` function listed.
6. Click on it, then click **Get Function Url**.
7. Open that URL in a new browser tab and add `?name=Cloud` to the end. You should see the same "Hello World" message you saw locally!

## Expected Result

Your Python code is now running live on Azure, automatically deployed from GitHub. Any future `git push` to the `main` branch will automatically update the live app.
