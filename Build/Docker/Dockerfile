FROM ubuntu

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y make
RUN apt-get install -y nasm
RUN apt-get install -y clang

VOLUME /root/env
WORKDIR /root/env

# ___ Docker ___

# Build:
#    docker build Docker -t osdevelopment                      | Build an Ubuntu-Linux container from the docker directory

# Run:
#    docker run -it --rm -v "${pwd}:/root/env" osdevelopment   | Run the container built from the above command with the current directory as its source (mount)

#___ Directories ___

# OS Makefile:
#    cd Build/LinuxBuildEnvironment                              | Navigate to build folders
#    make 16Bits_OS24                                            | Run the 16 bit OS makefile
#    cd Build/LinuxBuildEnvironment && make 16Bits_OS24          | Navigate to build folders and run the 16 bit OS makefile