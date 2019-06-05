#!/bin/sh
echo "Attempting to find ghost version in Dockerfile..."

ghost_version=$(grep -oP '(?<=FROM\sghost:)(.+)(?=-alpine)' Dockerfile | tail -1)

if [ -z "$ghost_version" ]; then
    echo "couldn't find a ghost version in Dockerfile"
    return
fi

echo "Found ghost:$ghost_version in Dockerfile"

echo "Attempting to find revision..."
revision=$(git tag | grep -oP "(?<=$ghost_version-)\d+")

if [ -z "$revision" ]; then
    revision=0
else
    echo "Found existing git tag for ghost version. Incrementing revision..."
    revision=$(("$revision" + 1))
fi

echo "Revision is $revision"

echo "##vso[build.updatebuildnumber]$ghost_version-$revision"