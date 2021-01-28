#!/bin/sh
echo "Attempting to find image in Dockerfile..."
image=${1-"amd64/ghost"}
image_tag=$(grep -oP "(?<=FROM\s$image:)(.+)(?=-alpine)" Dockerfile | tail -1)

if [ -z "$image_tag" ]; then
    echo "couldn't find a image '$image' in Dockerfile"
    exit 1
fi

echo "Found $image:$image_tag in Dockerfile"

echo "Attempting to find revision..."
revision=$(git tag --sort=taggerdate | grep -oP "(?<=$image_tag-)\d+" | tail -1)

if [ -z "$revision" ]; then
    revision=0
else
    echo "Found existing git tag for image. Incrementing revision..."
    revision=$((revision + 1))
fi

echo "Revision is $revision"

echo "##vso[task.setvariable variable=docker_tag]$image_tag-$revision" 