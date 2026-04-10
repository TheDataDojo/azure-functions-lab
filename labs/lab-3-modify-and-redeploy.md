# Lab 3: Modify and Redeploy

**Objective:** Change the "Hello World" response in your Python code, push the change to GitHub, and observe the automated redeployment.

**What you will do:**
1. Open the `function_app.py` file in VS Code.
2. Modify the default response message.
3. Save the file and commit the change.
4. Push the commit to the `main` branch.
5. Watch the GitHub Actions workflow run and verify the updated response in Azure.

## Steps

### Step 1: Modify the Code

1. In VS Code, open `src/function_app.py`.
2. Locate the line that returns the default "Hello World" message. It should look something like:
   ```python
   if name:
       return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
   ```
3. Change the message to something custom, for example:
   ```python
   if name:
       return func.HttpResponse(f"Greetings, {name}! You have successfully modified and redeployed this Azure Function.")
   ```
4. Save the file (Ctrl+S or Cmd+S).

### Step 2: Commit and Push

1. Open the terminal in VS Code or use the Source Control view (Ctrl+Shift+G).
2. Add the changed file to the staging area:
   ```bash
   git add src/function_app.py
   ```
3. Commit the change with a descriptive message:
   ```bash
   git commit -m "Update greeting message for Lab 3"
   ```
4. Push the commit to the `main` branch:
   ```bash
   git push origin main
   ```

### Step 3: Watch the Automated Redeployment

1. Go to your repository on GitHub.
2. Click the **Actions** tab.
3. You should see a new workflow run triggered by your recent commit.
4. Click on the workflow run to view the progress.
5. Wait for the build and deploy jobs to complete successfully (green checkmarks). This usually takes 1-2 minutes.

### Step 4: Verify the Updated Response

1. Go to the Azure Portal and navigate to your Function App.
2. Click **Functions** in the left menu, then select your `HelloWorldHttpTrigger` function.
3. Click **Get Function Url** and copy the URL.
4. Open the URL in a new browser tab, and add `?name=YourName` to the end (e.g., `&name=Alice` or `?name=Alice` depending on the URL format).
5. You should now see your updated custom message: "Greetings, Alice! You have successfully modified and redeployed this Azure Function."

## Validation

1. The code change was successfully pushed to GitHub.
2. The GitHub Actions workflow triggered automatically and completed without errors.
3. The live Azure Function returns the new, modified response.

## Expected Result

You have successfully completed the full CI/CD lifecycle for an Azure Function, from local development to automated deployment!
