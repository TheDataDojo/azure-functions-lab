# Lab 1: Create Function in VS Code

**Objective:** Set up a local Azure Function project in Visual Studio Code, write a simple HTTP-triggered Python function, and run it locally.

**What you will do:**
1. Install prerequisites and the Azure Functions extension.
2. Create a new Azure Functions project using the VS Code extension.
3. Install the required Python dependencies into a virtual environment.
4. Run the function locally and test the endpoint.

---

## Step 1: Install Prerequisites

Before starting, ensure you have the following installed on your machine:
- **Visual Studio Code**
- **Python 3.10 or 3.11** (ensure Python is added to your PATH)
- **Azure Functions Core Tools** (allows you to run functions locally)

In VS Code, install the following extensions from the Extensions view (`Ctrl+Shift+X`):
- **Python** (by Microsoft)
- **Azure Functions** (by Microsoft)

---

## Step 2: Create a New Project in VS Code

1. Open Visual Studio Code.
2. Click the **Azure** icon in the left Activity Bar (it looks like an 'A').
3. Under the **Workspace** section, click the **Create Function** button (a lightning bolt icon with a plus sign).
4. VS Code will prompt you for several details at the top of the screen:
   - **Folder:** Select a new empty folder on your computer (e.g., `my-local-function`).
   - **Language:** Select **Python**.
   - **Python Interpreter:** Select **Python 3.11** (or the version installed on your machine).
   - **Programming Model:** Select **Model V2**.
   - **Template:** Select **HTTP trigger**.
   - **Function Name:** Enter `HelloWorldHttpTrigger`.
   - **Authorization Level:** Select **Anonymous**.
5. VS Code will generate the project files, including `function_app.py`, `host.json`, and `requirements.txt`.

---

## Step 3: Install Dependencies

Before running the function, you must install the required Python packages into the virtual environment that VS Code just created.

1. Open the integrated terminal in VS Code (`Ctrl + \`` or **Terminal > New Terminal**).
2. Ensure your virtual environment is activated. Your terminal prompt should start with `(.venv)`.
   - *If it is not activated, run `.venv\Scripts\activate` (Windows) or `source .venv/bin/activate` (Mac/Linux).*
3. Run the following command to install the Azure Functions package:
   ```bash
   pip install -r requirements.txt
   ```

---

## Step 4: Run and Test Locally

1. Press **F5** (or click **Run > Start Debugging**) to start the function locally.
2. The terminal will output the local URL of your function. It should look like this:
   `http://localhost:7071/api/HelloWorldHttpTrigger`
3. Open a web browser and navigate to that URL. You should see a message asking you to pass a name in the query string.
4. Test it by appending `?name=Azure` to the URL:
   `http://localhost:7071/api/HelloWorldHttpTrigger?name=Azure`
5. The browser should respond with: *"Hello, Azure. This HTTP triggered function executed successfully."*
6. Stop the debugger in VS Code by pressing **Shift + F5** (or clicking the red square stop button).

## Validation

1. The function starts successfully without any `ModuleNotFoundError` exceptions.
2. The local endpoint `http://localhost:7071/api/HelloWorldHttpTrigger` is accessible.
3. The function returns a personalized greeting when a `name` parameter is provided.

## Expected Result

You now have a working Azure Function running on your local machine, ready to be deployed to the cloud.
