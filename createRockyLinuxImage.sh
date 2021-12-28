#!/bin/sh

echo -e "Starting build"
echo -e "----------------\n"

# Define output and Dockerfile path variables
scriptDir=$(dirname "${BASH_SOURCE[0]}")
outDir="${scriptDir}/out"
outFilePath="${outDir}/rockylinux-latest.tar"
dockerFilePath="${scriptDir}/Dockerfile"

# Remove the existing output directory if it already exists.
if [ -d "${outDir}" ]
then
    echo -e "- Output directory already exists."
    echo -e "\t- Deleting..."
    rm -rf "${outDir}"
fi

# Create a new output directory.
echo -e "- Creating output directory at '${outDir}'."
mkdir "${outDir}"

# Remove any existing RockyLinux images.
echo -e "- Removing any previously pulled RockyLinux images."
localRockyLinuxImgs=$(podman images | grep -Po '^docker\.io\/rockylinux\/rockylinux\s+(.+?)\s+\K([a-z0-9]{12})' | sort --unique)
for item in $( echo "${localRockyLinuxImgs[@]}" )
do
    echo -e "\t- Removing Image ID: ${item}"
    podman rmi "${item}" --force > /dev/null
done

# Pull the latest RockyLinux image from DockerHub.
echo -e "- Pulling the latest RockyLinux image from DockerHub."
echo -e "\n------- 'podman pull' output -------"
podman pull docker.io/rockylinux/rockylinux:latest
echo -e "------------------------------------\n"

# Run the image build.
echo -e "- Building the image."
echo -e "\n------- 'buildah bud' output -------"
buildah bud --tag wsl2-rockylinux "${dockerFilePath}"
echo -e "--------------------------------------\n"

# Start a container from the built image and get it's ID.
podman run -t --name=wsl2-rockylinux localhost/wsl2-rockylinux:latest bash ls /
containerId=$(podman container ls -a | grep -i wsl2-rockylinux | awk '{print $1}')

# Export the container to the output path.
echo -e "- Exporting container to: ${outFilePath}"
podman export $containerId > $outFilePath

# Cleanup container and image resources.
echo -e "- Cleaning up..."
podman container stop $containerId > /dev/null
podman container rm $containerId > /dev/null
builtImages=$(podman images | grep -Po '^localhost\/wsl2-rockylinux\s+(.+?)\s+\K([a-z0-9]{12})' | sort --unique)
for item in $( echo "${builtImages[@]}" )
do
    echo -e "\t- Removing Image ID: ${item}"
    podman rmi "${item}" --force > /dev/null
done

echo -e "\nBuild complete."
echo -e "----------------\n"
echo -e "Output file: ${outFilePath}"