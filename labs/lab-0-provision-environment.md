# Lab 0: Provision Environment

**Objective:** Automatically provision the required Azure infrastructure using a "Deploy to Azure" button.

**What you will do:**
1. Click the "Deploy to Azure" button in the README.
2. Fill out a simple form to create the necessary Azure resources.
3. Confirm the resources were created in the Azure Portal.

## Steps

### Step 1: Deploy to Azure

1. Open the main `README.md` file in this repository.
2. Locate the **Deploy to Azure** button under the "Deploy to Azure" section.
3. Click the button. This will redirect you to the Azure Portal.
4. If prompted, log in with your Azure credentials.

### Step 2: Configure the Deployment

1. On the "Custom deployment" screen in the Azure Portal, you will see a few fields to fill out.
2. **Subscription:** Select your active Azure subscription.
3. **Resource group:** Click "Create new" and enter a name (e.g., `rg-azure-functions-lab`).
4. **Region:** Choose a region close to you (e.g., `West US 2` or `North Europe`). The default is `West US 2`.
5. **Prefix:** Enter a short, unique prefix (3-10 lowercase characters, e.g., `aflab123`). This prefix will be used to generate names for your Storage Account, App Service Plan, and Function App.

### Step 3: Review and Create

1. Click the **Review + create** button at the bottom of the screen.
2. Wait a moment for validation to pass.
3. Click **Create**.
4. The deployment process will begin. This usually takes 1-2 minutes.

## Validation

1. Once the deployment is complete, click **Go to resource group**.
2. You should see the following resources created:
   - **Storage account:** Used by the Function App for internal state management.
   - **Application Insights:** Used for monitoring and logging.
   - **App Service plan:** The hosting plan (`Basic B1`) for your function. This plan is used to avoid quota issues common with the Consumption tier.
   - **Function App:** The actual Azure Function resource where your Python code will be deployed.

## Expected Result

You now have a fully provisioned, empty Azure Function App ready to receive your Python code.
