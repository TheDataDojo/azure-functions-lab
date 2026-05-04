# Lab 2: Deploy to Azure (VS Code & GitHub Actions)

**Objective:** Deploy your local Python function to Azure.

This lab covers the two primary ways to deploy code to an Azure Function App. You can either deploy directly from your local machine using the **VS Code Azure extension** (fastest for testing), OR set up a continuous deployment (CI/CD) pipeline using **GitHub Actions** (best for production).

Choose one path below.

---

## Path A: Deploy Directly from VS Code (Without GitHub)

This approach is ideal for rapid prototyping. It pushes your local code directly to the Azure Function App you provisioned in Lab 0.

### Step A1: Connect VS Code to Azure
1. Open your `src` folder in Visual Studio Code.
2. Click the **Azure** icon in the left Activity Bar (it looks like an 'A').
3. Under the **Resources** section, click **Sign in to Azure...** and follow the browser prompts to authenticate.
4. Once signed in, expand your Subscription and expand **Function App**.
5. You should see the Function App you created in Lab 0 (e.g., `func-aflab123`).

### Step A2: Deploy the Code
1. Look at the **Workspace** section in the Azure pane.
2. Click the **Deploy** button (a cloud icon with an up arrow).
3. Select **Deploy to Function App...**
4. Select your existing Function App from the list.
5. Click **Deploy** when prompted to overwrite previous deployments.
6. Wait for the deployment to finish. VS Code will show a notification in the bottom right corner.
7. Proceed to the **Validation** section below.

---

## Path B: Deploy via GitHub Actions (CI/CD)

This approach commits your code to GitHub and uses an automated pipeline to deploy it. This is the industry standard for production workloads.

### Step B1: Initialize Git and Push to GitHub
1. Open the terminal in VS Code.
2. Ensure you are in the root folder of this repository (e.g., `azure-functions-lab`).
3. Initialize Git, add files, and commit:
   ```bash
   git init
   git add .
   git commit -m "Initial commit of Azure Functions lab"
   ```
4. Go to [GitHub](https://github.com/) and log in.
5. Click the **+** icon in the top right and select **New repository**.
6. Name the repository `azure-functions-lab` (or similar). Leave it Public or Private, and **do NOT** initialize it with a README or .gitignore.
7. Click **Create repository** and copy the repository URL.
8. Back in your VS Code terminal, link your local repository to GitHub and push:
    ```bash
    git remote add origin https://github.com/YOUR_USERNAME/azure-functions-lab.git
    git branch -M main
    git push -u origin main
    ```

### Step B2: Set up GitHub Actions
You have two ways to configure the GitHub Actions workflow:

#### Option 1: Azure Deployment Center (Automated)
1. Go to the Azure Portal and find your Function App.
2. In the left menu, under **Deployment**, click **Deployment Center**.
3. On the **Settings** tab, set the **Source** dropdown to **GitHub**.
4. Authorize Azure to access your GitHub account if prompted.
5. Select your Organization, your Repository (`azure-functions-lab`), and your Branch (`main`).
6. Click **Save** at the top. Azure will automatically commit a workflow file to your repo and start the deployment.
7. In your VS Code terminal, run `git pull origin main` to download the new workflow file Azure created.

#### Option 2: Manual Configuration (Learn the Mechanics)
1. In VS Code, navigate to `.github/workflows/deploy.yml`. Notice it requires a secret named `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`.
2. Go to the Azure Portal, find your Function App, and click **Get publish profile** at the top of the Overview page.
3. Open the downloaded `.PublishSettings` file in a text editor and copy its entire contents.
4. Go to your GitHub repository in the browser.
5. Click **Settings** > **Secrets and variables** > **Actions**.
6. Click **New repository secret**.
7. Name the secret exactly: `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`
8. Paste the contents of the publish profile into the **Secret** field and click **Add secret**.
9. Go to the **Actions** tab in your GitHub repo, select the failed workflow run, and click **Re-run all jobs**.

---

## Validation

1. Go to the Azure Portal.
2. Navigate to your Function App and click **Functions** in the left menu.
3. You should see your `HelloWorldHttpTrigger` function listed.
4. Click on it, then click **Get Function Url**.
5. Open that URL in a new browser tab and add `?name=Cloud` to the end.

## Expected Result

You should see the same "Hello World" message you saw locally! Your Python code is now running live on Azure, deployed either directly from your IDE or automatically from GitHub.
