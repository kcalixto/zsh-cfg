# Pull Repository
git pull

# Get the last tag
lastTag=$(git describe --abbrev=0 --tags)

# Extract the version number without the 'v' prefix
version=$(echo $lastTag | cut -c 2-)

# Increment the last digit
newVersion=$(echo $version | awk -F. '{$NF=$NF+1}1' OFS=.)

# Add the 'v' prefix back
newTag="v$newVersion"

# Create new tag
git tag $newTag

# Push new tag
git push --tags