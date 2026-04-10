# Azure Functions "Lab in a Box"

Welcome to the Azure Functions "Lab in a Box"! This repository is designed to guide beginners through the full Azure Functions deployment cycle in **under 30 minutes**. You will provision infrastructure, create a Python function locally in VS Code, and set up automated deployment using GitHub Actions.

## Lab Overview

This hands-on lab covers:
1. Automatically provisioning Azure infrastructure
2. Creating and testing an Azure Function locally using VS Code
3. Deploying the function to Azure via GitHub Actions
4. Modifying the code and triggering an automated redeployment

## Prerequisites

Before starting, ensure you have the following installed and set up on your local machine:
- [Visual Studio Code](https://code.visualstudio.com/)
- [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local)
- [Python 3.9+](https://www.python.org/downloads/)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Git](https://git-scm.com/downloads)
- A [GitHub account](https://github.com/)
- An active [Azure subscription](https://azure.microsoft.com/free/)

## Deploy to Azure

Click the button below to provision the required Azure resources (Resource Group, Storage Account, Application Insights, and Function App).

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FTheDataDojo%2Fazure-functions-lab%2Fmain%2Finfra%2Fmain.json)

## Repository Structure

```text
.
├── .github/workflows/    # GitHub Actions deployment workflow
├── infra/                # Azure infrastructure templates (Bicep/ARM)
├── labs/                 # Step-by-step lab guides
├── src/                  # Azure Function source code
└── README.md             # This file
```

## Lab Guides

Please follow the labs in order. All detailed instructions are located in the `labs` folder:

- **[Lab 0: Provision Environment](./labs/lab-0-provision-environment.md)** - Deploy the required Azure resources using the "Deploy to Azure" button.
- **[Lab 1: Create Function in VS Code](./labs/lab-1-create-function-in-vscode.md)** - Set up your local project, write a Python HTTP trigger function, and test it locally.
- **[Lab 2: Push to GitHub and Deploy](./labs/lab-2-push-to-github-and-deploy.md)** - Commit your code, configure GitHub Actions, and deploy to Azure.
- **[Lab 3: Modify and Redeploy](./labs/lab-3-modify-and-redeploy.md)** - Make a code change, push it to GitHub, and watch the automated redeployment.

## Validation

Once all labs are complete, you will have a live Azure Function URL that returns your custom "Hello World" message. You can test this URL directly in your browser or using a tool like `curl`.

## Cleanup

To avoid incurring unexpected charges, delete the resource group created during Lab 0 when you are finished. You can do this via the Azure Portal or using the Azure CLI:

```bash
az group delete --name <your-resource-group-name> --yes --no-wait
```

## Troubleshooting

- **Function fails to start locally:** Ensure you have the correct Python version installed and that the Azure Functions Core Tools are up to date.
- **GitHub Actions deployment fails:** Verify that your `AZURE_RBAC_CREDENTIALS` or Publish Profile secret is correctly configured in your GitHub repository settings. Check the workflow logs for specific error messages.
