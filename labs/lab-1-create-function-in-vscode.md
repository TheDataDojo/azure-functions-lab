# Lab 1: Create Function in VS Code

**Objective:** Set up a local Azure Function project in Visual Studio Code, write a simple HTTP-triggered Python function, and run it locally.

**What you will do:**
1. Open the project folder in VS Code.
2. Review prerequisites and install necessary extensions.
3. Create a new Azure Functions project using the VS Code extension.
4. Choose the Python runtime and HTTP trigger template.
5. Run the function locally and test the endpoint.

## Steps

### Step 1: Open the Project in VS Code

1. Open your terminal or command prompt.
2. Navigate to the `src` folder in this repository.
3. Type `code .` to open the folder in Visual Studio Code.

### Step 2: Review Prerequisites

1. In VS Code, ensure you have the **Azure Functions** extension installed. You can find it in the Extensions view (Ctrl+Shift+X) by searching for "Azure Functions".
2. Also, ensure you have the **Python** extension installed.

### Step 3: Create a New Azure Functions Project

1. In VS Code, open the Command Palette (Ctrl+Shift+P).
2. Type `Azure Functions: Create New Project...` and select it.
3. Select the current folder (`src`) as the project location.
4. Choose **Python** as the language.
5. Choose a Python alias (e.g., `python3` or a specific virtual environment if you have one set up).
6. Select **HTTP trigger** as the template for your first function.
7. Provide a name for your function, such as `HelloWorldHttpTrigger`.
8. Choose **Anonymous** for the Authorization level. This allows anyone to call the function without an API key, simplifying our lab.

### Step 4: Run the Function Locally

1. Once the project is created, VS Code will generate several files, including `function_app.py` (if using the v2 programming model) or a folder named `HelloWorldHttpTrigger` with an `__init__.py` file (v1 model). We will assume the v2 model for modern Python functions.
2. Open `function_app.py` and review the generated code. It should look something like this:

```python
import azure.functions as func
import logging

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="HelloWorldHttpTrigger")
def HelloWorldHttpTrigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )
```

3. To run the function, press **F5** or go to the Run and Debug view and click the play button.
4. VS Code will start the Azure Functions Core Tools. You should see output in the Terminal panel.
5. Look for a line that says something like:
   `HelloWorldHttpTrigger: [GET,POST] http://localhost:7071/api/HelloWorldHttpTrigger`

### Step 5: Test the Local Endpoint

1. Ctrl+Click (or Cmd+Click on Mac) the URL in the terminal, or copy and paste it into your browser.
2. You should see the default response: "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
3. Try adding `?name=YourName` to the end of the URL (e.g., `http://localhost:7071/api/HelloWorldHttpTrigger?name=Alice`).
4. The response should change to "Hello, Alice. This HTTP triggered function executed successfully."

## Validation

1. The function runs locally without errors.
2. You can access the local endpoint via a browser or a tool like `curl`.
3. The function returns the expected default response and personalized response when a name is provided.

## Expected Result

You have successfully created and tested a local Python Azure Function in VS Code. You are now ready to deploy it to Azure.
