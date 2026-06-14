# Unofficial OpenFOAM Docker Images for CfdOF

Unofficial OpenFOAM Docker Images for CfdOF. This lets you to run newer
versions of OpenFOAM with CfdOF via Docker. The Dockerfiles pull Foundation and
OpenCFD/ESI versions of OpenFOAM from Docker Hub, install `gmsh`, `cfmesh` and
`hisa`, and configure a bashrc script to work with CfdOF.

At the time of writing, CfdOF 1.37.3 supports OpenFOAM Foundation 9 to 13, and
OpenCFD/ESI v2206 to v2512.

## Using pre-built images

Images are built against `dockerfile.foundation` and `dockerfile.opencfd` and
uploaded to GitHub Container Registry
(GHCR). The edition tags track the latest image configured for that OpenFOAM
edition.

- OpenFOAM Foundation - `ghcr.io/kktse/cfdof-openfoam:foundation`
- OpenCFD/ESI - `ghcr.io/kktse/cfdof-openfoam:opencfd`

To use the pre-built images with CfdOF pull the latest image from GHCR.

```bash
$ docker pull ghcr.io/kktse/cfdof-openfoam:foundation
# or
$ docker pull ghcr.io/kktse/cfdof-openfoam:opencfd
```

**WARNING**: It is not recommended to pull the Docker image directly from
FreeCAD and CfdOF, as it may not download all the necessary image layers.

In FreeCAD, navigate to the CfdOF preferences page by navigating to Edit >
Preferences > CfdOf. In the Software dependencies > Docker Container section,
toggle **Use docker** to true, and specify the **"Download from URL"** path to
the desired image name. For example, to use the OpenFOAM Foundation image,
set the "Download from URL" field to `ghcr.io/kktse/cfdof-openfoam:foundation`.
Proceed as usual to install the Docker container runtime per the [CfdOF
instructions](cfdof-docker-instructions).

## Building locally

To build an image manually, use the Dockerfile for the OpenFOAM edition you
want to build.

```bash
$ DOCKER_BUILDKIT=1 docker build \
    --build-arg="BASE_IMAGE=openfoam/openfoam11-paraview510:11" \
    -f dockerfile.foundation .
# or
$ DOCKER_BUILDKIT=1 docker build \
    --build-arg="BASE_IMAGE=opencfd/openfoam-dev:2512" \
    -f dockerfile.opencfd .
```

The OpenFOAM versions built by GitHub Actions are defined in the
`matrix.include` entries in `.github/workflows/docker-publish.yml`. The current
base images are:

Foundation builds compile `cfmesh-cfdof` from source. OpenCFD builds use the
`cartesianMesh` provided by the OpenCFD base image and install a small
`cartesianMesh -version` compatibility shim for CfdOF.

For Foundation images, set the CfdOF mesh object's number of meshing processes
to `1`. The parallel cfMesh path can fail during reconstruction with
`Non-empty processor patch "processor0to1" found in reconstructed mesh`.

Maintainers can also use the manual GitHub Actions workflow trigger to build a
one-off Foundation or OpenCFD image by supplying the desired version, base image
and runtime user. Manual builds always publish the versioned tag and can
optionally move the edition alias tag.

In FreeCAD, navigate to the CfdOF preferences page by navigating to Edit >
Preferences > CfdOf. In the Software dependencies > Docker Container section,
toggle **Use docker** to true, and specify the **"Download from URL"** path to
the image ID of the built image. Click on "Install Docker Container" and ignore
the error message, _"Error response from daemon: pull access denied"_. Proceed
as usual to install the Docker container runtime per the [CfdOF
instructions](cfdof-docker-instructions).

## Reverting to the default CfdOF Docker image

The default image URL used by CfdOF is
[`docker.io/mmcker/cfdof-openfoam`](https://hub.docker.com/r/mmcker/cfdof-openfoam).

In FreeCAD, navigate to the CfdOF preferences page by navigating to Edit >
Preferences > CfdOf. In the Software dependencies > Docker Container section,
toggle **Use docker** to true, and specify the **"Download from URL"** path as
`docker.io/mmcker/cfdof-openfoam`.

## Installation sources

Foundation and OpenCFD/ESI images are based on the `BASE_IMAGE` selected in
`.github/workflows/docker-publish.yml` or supplied to the manual workflow.
`gmsh` is installed from the selected base image's apt repositories.

For Foundation images, `cfmesh` is compiled from source from
[cfMesh-CfdOF](https://sourceforge.net/projects/cfmesh-cfdof/). For OpenCFD/ESI
images, the version of `cartesianMesh` packaged in the base image is used with a
CfdOF-compatible `-version` shim.

`hisa` is compiled from source from
[HiSA](https://sourceforge.net/projects/hisa).

[cfdof-docker-instructions]: https://github.com/jaheyns/CfdOF?tab=readme-ov-file#docker-container-install
