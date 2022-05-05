
#!/usr/bin/env bash

source "./.github/workflows/scripts/e2e-utils.sh"

SEMVER=$(gh release list -L 1 | cut -f1)
PATCH=$(echo "$SEMVER" | cut -d '.' -f3)
if ! [[ "$PATCH" =~ ^[0-9]+$ ]]; then
    echo "patch ($PATCH) is not a number"
    exit 1
fi

NEW_PATCH=$((PATCH + 1))
MAJOR_MINOR=$(echo "$SEMVER" | cut -d '.' -f1,2)
NEW_SEMVER="$MAJOR_MINOR.$NEW_PATCH"

gh release create "$NEW_SEMVER" --notes "e2e release creation: $NEW_SEMVER"
