# Unofficial OpenFOAM Docker Image for CfdOF

Unofficial OpenFOAM Docker Images for CfdOF. Use these images to run newer
versions of OpenFOAM with the CfdOF Docker container runtime feature. The dockerfile
pulls the latest Foundation and OpenCFD/ESI versions of OpenFOAM from Docker
Hub, configures the environment for compatibility with CfdOF, and installs `gmsh`,
`cfmesh` and `hisa`.

At the time of writing, CfdOF 1.25.13 supports OpenFOAM Foundations versions 9
through 10, and OpenCFD/ESI v2006 to v2306.

## Building manually

To build the image manually, run the following command.

```bash
$ DOCKER_BUILDKIT=1 docker build --build-arg="TARGET=foundation" -f dockerfile .
# or
$ docker build --build-arg="TARGET=foundation" -f dockerfile .
```

You can pick between `foundation` and `opencfd` builds of OpenFOAM. These correspond to the following images and versions:

- foundation: [`openfoam/openfoam10-paraview56:10`](https://hub.docker.com/r/openfoam/openfoam10-paraview510)
- opencfd: [`opencfd/openfoam-default:2306`](https://hub.docker.com/r/opencfd/openfoam-default)

In CfdOF, configure the "Download from URL" field as the image id. You can
retrieve this by inspecting the end of the build output. Clicking on "Install
Docker Container" will result in an error message _"Error response from daemon:
pull access denied"_ - ignore this message. Verify the configuration by
clicking "Run dependency checker".

## Reverting to the default CfdOF Docker image

The default image URL is [`docker.io/mmcker/cfdof-openfoam`](https://hub.docker.com/r/mmcker/cfdof-openfoam).
