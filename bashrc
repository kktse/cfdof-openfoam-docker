# cfdof bashrc
if [ -d "/openfoam" ]; then
   source /openfoam/bash.rc
fi

if [ -d "/opt/openfoam9" ]; then
   source /opt/openfoam9/etc/bashrc
fi

if [ -d "/opt/openfoam10" ]; then
   source /opt/openfoam10/etc/bashrc
fi

if [ -d "/opt/openfoam11" ]; then
   source /opt/openfoam11/etc/bashrc
fi

export FOAM_USER_APPBIN=/usr/local/bin
export FOAM_USER_LIBBIN=/usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/bin:$PATH
