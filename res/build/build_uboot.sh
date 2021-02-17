# 可能修改的部分
export board="vexpress_a9"
export cfgfile="vexpress_ca9x4_defconfig"
export arch="arm"
#export compile_tools="gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabi"
export compile_tools="gcc-linaro-7.5.0-2019.12-i686_arm-linux-gnueabi"
echo "Build for $arch "
# end

export uboot_ver=$(basename $(pwd))
export output=${build_dir}/${board}/${uboot_ver}
export board_dir=${test_dir}/qemu/arm/${board}/${uboot_ver}

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

echo "make $params $cfgfile O=$output"
make $params $cfgfile O=$output
echo "make $params O=$output -j2" 
make $params O=$output -j2 

echo ""
echo "Copy u-boot to ${board_dir}"
echo ""

if [ ! -d "$board_dir" ]; then
  mkdir -p "$board_dir"
fi

cp $output/u-boot $board_dir

