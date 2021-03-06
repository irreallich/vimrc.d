# 可能修改的部分
export board="vexpress_a9"
export arch="arm"
#export compile_tools="gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabi"
export compile_tools="gcc-linaro-7.5.0-2019.12-i686_arm-linux-gnueabi"
echo "Build for $arch "
# end

export busybox_ver=$(basename $(pwd))
export output=${build_dir}/${board}/${busybox_ver}
export board_dir=${test_dir}/qemu/arm/${board}/${busybox_ver}

if [ ! -d "$output" ]; then
  mkdir -p "$output"
fi

# 此函数用来判断路径是否在path中
function isexist()
{
    source_str=$1
    test_str=$2

    strings=$(echo $source_str | sed 's/:/ /g')
    for str in $strings
    do
        if [ $test_str = $str ]; then
            return 0
        fi
    done
    return 1
}

export compile_tools_dir="${toolchains_dir}/${compile_tools}/bin"
export params=" ARCH=$arch CROSS_COMPILE=arm-linux-gnueabi- "
if isexist $PATH ${compile_tools_dir}; then
    echo "${compile_tools_dir} already in path"
else
    export PATH=${compile_tools_dir}:$PATH
fi

echo "make $params O=$output -j2" 
make $params O=$output defconfig -j2 
#make $params O=$output menuconfig -j2 
make $params O=$output -j2 
make $params O=$output install -j2 

if [ ! -d "$board_dir" ]; then
  mkdir -p "$board_dir"
fi

echo "copy _install to $board_dir"
cp -ra $output/_install $board_dir
