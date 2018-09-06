#!/bin/bash


debug_str="import pydevd;pydevd.settrace('localhost', port=8081, stdoutToServer=True, stderrToServer=True)"
# pydevd module path
export PYTHONPATH=/home/shhs/Desktop/user/soft/pycharm-2018.1.4/debug-eggs/pycharm-debug-py3k.egg_FILES

insert_debug_string()
{
    file=$1
    line=$2
    debug_string=$3
    debug=$4

    value=`sed -n ${line}p "$file"`

    if [ "$value" != "$debug_string" ] && [ "$debug" = debug ]
    then
    echo "++Insert $debug_string in line_${line}++"

    sed "${line}s/^/\n/" -i $file
    sed -i "${line}s:^:${debug_string}:" "$file"
    fi
}

delete_debug_string()
{
    file=$1
    line=$2
    debug_string=$3

    value=`sed -n ${line}p "$file"`
    if [ "$value" = "$debug_string" ]
    then
    echo "--Delete $debug_string in line_${line}--"
    sed "${line}d" -i "$file"
    fi
}

make_build_dir()
{
    buildPath=$1
    rebuild=$2

    if [ -d "$buildPath" ] && [ "$rebuild" = rebuild ]
    then
    rm -rf "$buildPath"
    fi

    if [ ! -d "$buildPath" ]
    then
    mkdir -p "$buildPath"
    fi
}

build_caffe()
{
    rebuild=$1
    buildType=$2

    cudapath=/usr/local/cuda-8.0
    cudnnpath=/usr/local/cudnn_v5.1_cuda8.0
    export LD_LIBRARY_PATH="$cudnnpath"/lib64:"$cudapath"/lib64

    cd lib/caffe
    buildPath=build
    make_build_dir $buildPath $rebuild

    cd build
    cmake -DCMAKE_BUILD_TYPE="$buildType" -DCMAKE_PREFIX_PATH="/usr/local/cudnn_v5.1_cuda8.0;${cudapath};/home/shhs/env/opencv3_2_sys" -DCUDNN_ROOT=$cudnnpath ..
    make -j8
    cd ../..
}

if [ "$1" = build ]
then
#   ./run.sh build norebuild
#   python: python3.5
#   The version of python must be compatible with boost.
    rebuild=$2
    build_caffe "$rebuild" Debug


fi