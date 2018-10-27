#!/bin/bash

cd ..

CURRENT_VERSION=$(cat lib/core/constants.rb | grep VERSION | cut -d '"' -f 2)

TO_UPDATE=(
  lib/core/constants.rb
)

echo -n "Current version is $CURRENT_VERSION, select new version: "
read NEW_VERSION
echo "Creating v$NEW_VERSION...\n"

for file in "${TO_UPDATE[@]}"
do
    echo "Patching $file ..."
    sed -i "s/$CURRENT_VERSION/$NEW_VERSION/g" $file
    git add $file
done


git commit -m "Releasing v$NEW_VERSION"
git push

git tag -a v$NEW_VERSION -m "Release v$NEW_VERSION"
git push origin v$NEW_VERSION

echo
echo "Version $NEW_VERSION pushed to GitHub. Building gem and pushing to RubyGems now..."

gem build radon.gemspec

gem push radon-$NEW_VERSION.gem