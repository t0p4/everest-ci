# This script is responsible to delete the local docker image.

param
(
    [Parameter(Mandatory=$true)]
    [String] $ContainerImageName
)

# Remove image, but first validate the image exists.
$images = docker images --format '{{json .}}' | ConvertFrom-Json
$images | ForEach-Object {
    $image = $_.Repository + ":" + $_.Tag
    if ($image -eq $ContainerImageName) {
        docker rmi $ContainerImageName -f
    }
}