# GitHub Pages Status Check

## Manual Check Steps

To check if GitHub Pages are enabled for your repository:

### 1. Check Repository Settings
1. Go to: https://github.com/Digital-Data-Co/forge-docs
2. Click on **Settings** tab (top right of the repository)
3. Scroll down to **Pages** in the left sidebar
4. Check the current configuration

### 2. Expected Configuration
- **Source**: Should be set to "GitHub Actions" (not "Deploy from a branch")
- **Status**: Should show "Your site is live at https://digital-data-co.github.io/forge-docs/"

### 3. Check Actions Permissions
1. In the same Settings page, go to **Actions** → **General**
2. Scroll down to **Workflow permissions**
3. Verify:
   - "Read and write permissions" is selected
   - "Allow GitHub Actions to create and approve pull requests" is checked

### 4. Check Recent Workflows
1. Go to the **Actions** tab in your repository
2. Look for the "Deploy mdBook to GitHub Pages" workflow
3. Check if it has run successfully

## Quick Status Indicators

### ✅ Pages Enabled (Correct Setup)
- Pages section shows "Your site is live at https://digital-data-co.github.io/forge-docs/"
- Source is set to "GitHub Actions"
- Recent workflow runs show successful deployments

### ❌ Pages Not Enabled
- Pages section shows "Pages settings" or "Choose a source"
- No live site URL displayed
- No recent workflow runs

### ⚠️ Partial Setup
- Pages enabled but source set to branch deployment
- Workflow permissions not properly configured
- Workflows failing due to permission issues

## Troubleshooting

### If Pages Are Not Enabled:
1. In Settings → Pages:
   - Select "GitHub Actions" as the source
   - Save the settings

### If Workflow Permissions Are Wrong:
1. In Settings → Actions → General:
   - Select "Read and write permissions"
   - Check "Allow GitHub Actions to create and approve pull requests"
   - Save the settings

### If Workflows Are Failing:
1. Go to Actions tab
2. Click on the failed workflow run
3. Check the error messages
4. Common issues:
   - Missing permissions
   - Pages not enabled
   - Invalid configuration

## Test the Setup

After making any changes, test by:
1. Making a small change to any `.md` file in `src/`
2. Committing and pushing the change
3. Watching the Actions tab for the deployment workflow
4. Checking if the site updates at https://digital-data-co.github.io/forge-docs/
