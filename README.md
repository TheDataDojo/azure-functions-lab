# Azure Functions "Lab in a Box"

Welcome to the Azure Functions "Lab in a Box"! This repository guides beginners through the full Azure Functions deployment cycle in **under 30 minutes**. You will provision infrastructure on Azure, create a Python function locally in VS Code, and set up automated deployment using GitHub Actions.

## Lab Overview

This hands-on lab covers:

1. Automatically provisioning Azure infrastructure
2. Creating and testing an Azure Function locally using VS Code
3. Deploying the function to Azure via GitHub Actions
4. Modifying the code and triggering an automated redeployment

## Prerequisites

Before starting, ensure you have the following installed and configured on your local machine:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local)
- [Python 3.9+](https://www.python.org/downloads/)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Git](https://git-scm.com/downloads)
- A [GitHub account](https://github.com/)
- An active [Azure subscription](https://azure.microsoft.com/free/)

## Deploy to Azure

Click the button below to provision all required Azure resources into a new Resource Group.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FBloodliveMSFT%2Fazure-functions-lab%2Fmain%2Finfra%2Fmain.json)

> **How the button works:** The button links directly to the compiled ARM template (`infra/main.json`) stored in this repository. The Azure Portal reads the template from the raw GitHub URL and presents a simple deployment form. You only need to provide a short **prefix** (3–10 characters) and choose a **region** — all resource names are derived from the prefix automatically.
>
> **If you fork or transfer this repo**, update the two path segments in the button URL to match your GitHub username/org and repository name:
> ```
> https://portal.azure.com/#create/Microsoft.Template/uri/
>   https%3A%2F%2Fraw.githubusercontent.com%2F{YOUR_ORG}%2F{YOUR_REPO}%2Fmain%2Finfra%2Fmain.json
> ```

### What gets provisioned

| Resource | Purpose |
|---|---|
| Storage Account | Required internal storage for the Function App runtime |
| Application Insights | Monitoring and live log streaming |
| App Service Plan (Basic B1) | Reliable Linux hosting — avoids Consumption/Dynamic quota limits |
| Function App (Python 3.9) | The target for your deployed function code |

> **Why Basic B1 instead of Consumption?** The Consumption (Y1/Dynamic) plan requires a "Dynamic VMs" quota that is frequently exhausted on new, trial, or restricted Azure subscriptions — especially in East US. The Basic B1 plan uses standard VM quota which is broadly available and avoids that failure entirely. It costs slightly more than Consumption but is far more reliable for demos and labs.

> **Default region:** `West US 2`. You can change this during deployment. Recommended alternatives: `West US 3`, `East US 2`, `North Europe`, `UK South`.

## Repository Structure

```text
.
├── .github/workflows/    # GitHub Actions deployment workflow
├── infra/                # Azure infrastructure (Bicep source + compiled ARM JSON)
├── labs/                 # Step-by-step lab guides
├── src/                  # Azure Function source code
└── README.md             # This file
```

## Lab Guides

Follow the labs in order. All detailed instructions are in the `labs/` folder:

| Lab | Description |
|---|---|
| [Lab 0: Provision Environment](./labs/lab-0-provision-environment.md) | Deploy Azure resources using the Deploy to Azure button |
| [Lab 1: Create Function in VS Code](./labs/lab-1-create-function-in-vscode.md) | Create, run, and test the function locally |
| [Lab 2: Push to GitHub and Deploy](./labs/lab-2-push-to-github-and-deploy.md) | Commit code and deploy via GitHub Actions |
| [Lab 3: Modify and Redeploy](./labs/lab-3-modify-and-redeploy.md) | Change the response and watch CI/CD redeploy it |
| [Lab 4: Deploy to an Existing Function App](./labs/lab-4-use-existing-function-app.md) | Use VS Code to deploy directly to a pre-provisioned Function App, then automate it with GitHub Actions |

## Validation

Once all labs are complete, you will have a live Azure Function URL that returns your custom response. Test it directly in a browser or with `curl`:

```bash
curl "https://<your-function-app-name>.azurewebsites.net/api/HelloWorldHttpTrigger?name=World"
```

## Cleanup

To avoid ongoing charges, delete the resource group when you are done:

```bash
az group delete --name <your-resource-group-name> --yes --no-wait
```

## Troubleshooting

| Problem | Fix |
|---|---|
| Deploy to Azure button shows a template error | Confirm `infra/main.json` exists on the `main` branch and the URL in the button matches your org/repo name |
| Deployment fails with quota error | Switch to a different region (e.g., `West US 3` or `North Europe`) during the deployment form |
| Function fails to start locally | Ensure Python 3.9+ and Azure Functions Core Tools are installed and up to date |
| GitHub Actions deployment fails | Verify the `AZURE_FUNCTIONAPP_PUBLISH_PROFILE` secret is set correctly in your repo settings |
