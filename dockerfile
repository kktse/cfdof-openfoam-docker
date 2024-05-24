ARG TARGET="foundation"

FROM opencfd/openfoam-default:2306 as opencfd
ENV USER="root"

FROM openfoam/openfoam10-paraview56:10 as foundation
ENV USER="openfoam"

FROM ${TARGET} as build

SHELL ["/bin/bash", "-c"]

# Install required packages
USER root
RUN apt-get update && \
    apt-get install -y build-essential python3-pip python-is-python3 unzip gmsh

# Setup bashrc
COPY bashrc /etc/bashrc

# Install gmsh
WORKDIR /home/openfoam

# Install gmsh
WORKDIR /home/openfoam
RUN wget https://sourceforge.net/projects/cfmesh-cfdof/files/cfmesh-cfdof.zip/download -O cfmesh-cfdof.zip && \
    unzip cfmesh-cfdof.zip && \
    rm cfmesh-cfdof.zip
WORKDIR /home/openfoam/cfmesh-cfdof
RUN find . -type f -name Allwmake -exec sed -i 's/wmake/wmake -j/g' {} +;
RUN source /etc/bashrc && \
    ./Allwmake
RUN rm -r /home/openfoam/cfmesh-cfdof 

# Install HiSA
WORKDIR /home/openfoam
RUN wget https://sourceforge.net/projects/hisa/files/hisa-master.zip/download -O hisa-master.zip && \
    unzip hisa-master.zip && \
    rm hisa-master.zip
WORKDIR /home/openfoam/hisa-master
RUN find . -type f -name Allwmake -exec sed -i 's/wmake/wmake -j/g' {} +;
RUN source /etc/bashrc && \
    ./Allwmake
RUN rm -r /home/openfoam/hisa-master

USER ${USER}