# Lab 5: Create and Deploy Directly from VS Code

**Objective:** Build a brand new Azure Function in Visual Studio Code from scratch, test it locally, and deploy it directly to Azure using the VS Code Azure extension—all without using GitHub or CI/CD pipelines.

This lab covers the "inner loop" developer experience, which is perfect for rapid prototyping and testing before committing code to a repository.

**What you will do:**
1. Create a new Azure Functions project in VS Code.
2. Write a simple Python HTTP trigger function.
3. Run and test the function locally.
4. Deploy the function directly to an Azure Function App using the VS Code extension.

---

## Step 1: Create a New Project in VS Code

1. Open Visual Studio Code.
2. Click the **Azure** icon in the left Activity Bar (it looks like an 'A').
3. Under the **Workspace** section, click the **Create Function** button (a lightning bolt icon with a plus sign).
4. VS Code will prompt you for several details at the top of the screen:
   - **Folder:** Select a new empty folder on your computer (e.g., `my-new-function`).
   - **Language:** Select **Python**.
   - **Python Interpreter:** Select **Python 3.11** (or the version installed on your machine).
   - **Programming Model:** Select **Model V2**.
   - **Template:** Select **HTTP trigger**.
   - **Function Name:** Enter `HelloWorldHttpTrigger`.
   - **Authorization Level:** Select **Anonymous**.
5. VS Code will generate the project files, including `function_app.py`, `host.json`, and `requirements.txt`.

## Step 2: Install Dependencies

Before running the function, you must install the required Python packages into the virtual environment that VS Code just created.

1. Open the integrated terminal in VS Code (`Ctrl + \`` or **Terminal > New Terminal**).
2. Ensure your virtual environment is activated. Your terminal prompt should start with `(.venv)`.
   - *If it is not activated, run `.venv\Scripts\activate` (Windows) or `source .venv/bin/activate` (Mac/Linux).*
3. Run the following command to install the Azure Functions package:
   ```bash
   pip install -r requirements.txt
   ```

## Step 3: Run and Test Locally

1. Press **F5** (or click **Run > Start Debugging**) to start the function locally.
2. The terminal will output the local URL of your function. It should look like this:
   `http://localhost:7071/api/HelloWorldHttpTrigger`
3. Open a web browser and navigate to that URL. You should see a message asking you to pass a name in the query string.
4. Test it by appending `?name=Azure` to the URL:
   `http://localhost:7071/api/HelloWorldHttpTrigger?name=Azure`
5. The browser should respond with: *"Hello, Azure. This HTTP triggered function executed successfully."*
6. Stop the debugger in VS Code by pressing **Shift + F5** (or clicking the red square stop button).

## Step 4: Deploy Directly to Azure

Now that the function works locally, we will push the code directly to Azure.

1. Click the **Azure** icon in the left Activity Bar.
2. Under the **Resources** section, ensure you are signed in to Azure.
3. Expand your subscription, right-click on **Function App**, and select **Create Function App in Azure (Advanced)...**
   - *Note: If you already provisioned a Function App in Lab 0, you can skip creation and just right-click your existing app and select **Deploy to Function App...***
4. If creating a new one, follow the prompts:
   - **Name:** Enter a globally unique name (e.g., `my-func-app-123`).
   - **Runtime stack:** Select **Python 3.11**.
   - **Resource Group:** Select an existing one or create a new one.
   - **Location:** Select a region close to you.
   - **Hosting Plan:** Select **App Service Plan** and choose **Basic B1** (to avoid Consumption quota issues).
5. Once the Function App is created in Azure, look under the **Workspace** section again.
6. Click the **Deploy** button (a cloud icon with an up arrow).
7. Select **Deploy to Function App...**
8. Select the Function App you just created (or the one from Lab 0).
9. Click **Deploy** when prompted to overwrite previous deployments.

## Validation

1. Once the deployment finishes, VS Code will show a notification in the bottom right corner.
2. Click **View Output** to see the deployment logs.
3. Go to the Azure Portal, find your Function App, and click on the **Functions** blade on the left menu.
4. You should see `HelloWorldHttpTrigger` listed.
5. Click on it, then click **Get Function Url**.
6. Paste the URL into your browser and add `?name=Cloud` to the end.
7. You should see the success message returned from your live Azure Function!
