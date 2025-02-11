#!/bin/bash

# Exit on error
set -e

echo "🔄 Syncing with upstream repository..."

# Store the current branch name
CURRENT_BRANCH=$(git branch --show-current)

# Add upstream remote if it doesn't exist
if ! git remote | grep -q "upstream"; then
    echo "📦 Adding upstream remote..."
    git remote add upstream https://github.com/browserbase/stagehand.git
fi

# Fetch the latest changes from upstream
echo "⬇️ Fetching latest changes from upstream..."
git fetch upstream

# Ensure we're on our main branch
echo "🔀 Switching to main branch..."
git checkout main

# Merge upstream changes
echo "🔄 Rebasing on upstream main..."
git rebase upstream/main

# Apply our custom changes
echo "🛠️ Applying our customizations..."

# Update package.json with our private fork details
npm pkg set name="@anon/private-stagehand" \
    repository.url="git+https://github.com/anon-dot-com/private-stagehand.git" \
    bugs.url="https://github.com/anon-dot-com/private-stagehand/issues" \
    homepage="https://github.com/anon-dot-com/private-stagehand#readme"

# Commit our changes if there are any
if [[ -n $(git status -s) ]]; then
    echo "💾 Committing customizations..."
    git add package.json
    git commit -m "chore: update package details for private fork"
fi

# Push changes
echo "⬆️ Pushing changes..."
git push origin main

# Return to the original branch
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🔙 Returning to branch $CURRENT_BRANCH..."
    git checkout "$CURRENT_BRANCH"
fi

echo "✅ Sync complete!" 