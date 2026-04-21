# Lab 0: Provision Environment

**Objective:** Provision the required Azure infrastructure for your Function App.

You can complete this lab using either the **automated "Deploy to Azure" button** (fastest) OR the **manual Azure Portal UI** (best for learning the components). Choose one path below.

---

## Path A: Automated Provisioning (Deploy to Azure Button)

**What you will do:**
1. Click the "Deploy to Azure" button in the README.
2. Fill out a simple form to create the necessary Azure resources.
3. Confirm the resources were created in the Azure Portal.

### Step A1: Deploy to Azure
1. Open the main `README.md` file in this repository.
2. Locate the **Deploy to Azure** button under the "Deploy to Azure" section.
3. Click the button. This will redirect you to the Azure Portal.
4. If prompted, log in with your Azure credentials.

### Step A2: Configure the Deployment
1. On the "Custom deployment" screen in the Azure Portal, you will see a few fields to fill out.
2. **Subscription:** Select your active Azure subscription.
3. **Resource group:** Click "Create new" and enter a name (e.g., `rg-azure-functions-lab`).
4. **Region:** Choose a region close to you (e.g., `West US 2` or `North Europe`). The default is `West US 2`.
5. **Prefix:** Enter a short, unique prefix (3-10 lowercase characters, e.g., `aflab123`). This prefix will be used to generate names for your Storage Account, App Service Plan, and Function App.

### Step A3: Review and Create
1. Click the **Review + create** button at the bottom of the screen.
2. Wait a moment for validation to pass, then click **Create**.
3. The deployment process will begin. This usually takes 1-2 minutes. Proceed to the **Validation** section below.

---

## Path B: Manual Provisioning (Azure Portal UI)

**What you will do:**
1. Create a Resource Group to hold your resources.
2. Create a Function App (which automatically creates the required Storage Account and App Service Plan).

### Step B1: Create a Resource Group
1. Log in to the [Azure Portal](https://portal.azure.com).
2. Search for **Resource groups** in the top search bar and select it.
3. Click **+ Create**.
4. **Subscription:** Select your active subscription.
5. **Resource group:** Enter `rg-azure-functions-lab`.
6. **Region:** Select a region close to you (e.g., `West US 2`).
7. Click **Review + create**, then click **Create**.

### Step B2: Create the Function App
1. In the top search bar, search for **Function App** and select it.
2. Click **+ Create** and select **Consumption** or **Premium/Dedicated** (for this lab, we recommend the **Dedicated** plan using the **Basic B1** SKU to avoid quota issues, but Consumption works if your subscription allows it).
3. On the **Basics** tab:
   - **Subscription:** Select your active subscription.
   - **Resource Group:** Select `rg-azure-functions-lab`.
   - **Function App name:** Enter a globally unique name (e.g., `func-aflab123`).
   - **Do you want to deploy code or container image?** Select **Code**.
   - **Runtime stack:** Select **Python**.
   - **Version:** Select **3.11** (or 3.10).
   - **Region:** Select the same region as your resource group.
   - **Operating System:** Select **Linux**.
4. On the **Hosting** tab:
   - Ensure a new **Storage account** is being created automatically.
   - **Plan type:** Select **App service plan** (Dedicated).
   - **Pricing plan:** Click "Change size" and select **B1** under the Basic/Dev/Test tier.
5. Click **Review + create** at the bottom of the screen.
6. Wait for validation to pass, then click **Create**.
7. The deployment will take 1-2 minutes. Proceed to the **Validation** section below.

---

## Validation

1. Once the deployment is complete (via Path A or Path B), click **Go to resource group**.
2. You should see the following resources created:
   - **Storage account:** Used by the Function App for internal state management.
   - **Application Insights:** Used for monitoring and logging.
   - **App Service plan:** The hosting plan (`Basic B1`) for your function.
   - **Function App:** The actual Azure Function resource where your Python code will be deployed.

## Expected Result

You now have a fully provisioned, empty Azure Function App ready to receive your Python code.
