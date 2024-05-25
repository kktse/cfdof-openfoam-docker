# Unofficial OpenFOAM Docker Images for CfdOF

Unofficial OpenFOAM Docker Images for CfdOF. This lets you to run newer
versions of OpenFOAM with CfdOF via Docker. The dockerfile pulls the latest
Foundation and OpenCFD/ESI versions of OpenFOAM from Docker Hub, installs
`gmsh`, `cfmesh` and `hisa`, and configures a bashrc script to work with CfdOF.

At the time of writing, CfdOF 1.25.13 supports OpenFOAM Foundation 9 to 10, and
OpenCFD/ESI v2006 to v2306.

## Using pre-built images

Images are built against `dockerfile` and uploaded to GitHub Container Registry
(GHCR). Two image tags are provided.

- OpenFOAM Foundation 10 - `ghcr.io/kktse/cfdof-openfoam:foundation`
- OpenCFD/ESI v2306 - `ghcr.io/kktse/cfdof-openfoam:opencfd`

To use the pre-built images with CfdOF pull the desired image from GHCR.

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
the desired image name. For example, to use the OpenFOAM Foundation 10 image,
set the "Download from URL" field to `ghcr.io/kktse/cfdof-openfoam:foundation`.
Proceed as usual to install the Docker container runtime per the [CfdOF
instructions](cfdof-docker-instructions).

## Building locally

To build the image manually, run the following command.

```bash
$ DOCKER_BUILDKIT=1 docker build --build-arg="TARGET=foundation" -f dockerfile .
# or
$ docker build --build-arg="TARGET=foundation" -f dockerfile .
```

The OpenFOAM distribution can be selected with the `TARGET` argument. Two
options are available: `foundation` and `opencfd`. These correspond to the
following base images:

- foundation: [`openfoam/openfoam10-paraview56:10`](https://hub.docker.com/r/openfoam/openfoam10-paraview510)
- opencfd: [`opencfd/openfoam-default:2306`](https://hub.docker.com/r/opencfd/openfoam-default)

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

Foundation images are based on
[`openfoam/openfoam10-paraview56:10`](https://hub.docker.com/r/openfoam/openfoam10-paraview510).
`gmsh` is installed from the Ubuntu Focal 20.04 LTS repositories, which at the
time of writing is version [4.4.1](https://packages.ubuntu.com/focal/gmsh)

OpenCFD/ESI images are based on
[`opencfd/openfoam-default:2306`](https://hub.docker.com/r/opencfd/openfoam-default).
`gmsh` is installed from the Ubuntu Jammy 22.04 LTS repositories, which at the
time of writing is version [4.8.4](https://packages.ubuntu.com/jammy/gmsh)

`cfmesh` is compiled from source from
[cfMesh-CfdOF](https://sourceforge.net/projects/cfmesh-cfdof/).

`hisa` is compiled from source from
[HiSA](https://sourceforge.net/projects/hisa).

[cfdof-docker-instructions]: https://github.com/jaheyns/CfdOF?tab=readme-ov-file#docker-container-install
