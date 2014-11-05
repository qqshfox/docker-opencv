FROM ubuntu:14.04
MAINTAINER Hanfei Shen <qqshfox@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    patch \
    cmake \
    g++ \
    zlib1g-dev \
    libjpeg-dev \
    libwebp-dev \
    libpng12-dev \
    libtiff5-dev \
    libjasper-dev \
    libopenexr-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libeigen3-dev \
    libtbb-dev \
    python2.7-dev \
    python2.7-numpy \
    python3-dev \
    python3-numpy \
    ant \
    default-jdk

ENV OPENCV_VERSION 3.0.0-alpha
ADD hdr_parser.patch /tmp/
RUN mkdir -p /src && \
    curl -sSL https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.tar.gz | tar -xzC /src && \
    cd /src/opencv-$OPENCV_VERSION && \
    patch -p0 -i /tmp/hdr_parser.patch && \
    mkdir build && \
    cd build && \
    cmake -DWITH_QT=OFF -DWITH_GTK=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_1394=OFF -DWITH_FFMPEG=ON -DWITH_GSTREAMER=ON -DWITH_V4L=OFF -DWITH_EIGEN=ON -DWITH_TBB=ON -DBUILD_DOCS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF .. && \
    make && \
    make install && \
    ldconfig && \
    rm -rf /src/opencv-$OPENCV_VERSION /tmp/hdr_parser.patch
