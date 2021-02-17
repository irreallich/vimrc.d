# 可能修改的部分
export board="vexpress_a9"
export cfgfile="vexpress_defconfig "
export arch="arm"
#export compile_tools="gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabi"
export compile_tools="gcc-linaro-7.5.0-2019.12-i686_arm-linux-gnueabi"
export loadaddr="0x60003000"
echo "Build for $arch "
# end

export kernel_ver=$(basename $(pwd))
export output=${build_dir}/${board}/${kernel_ver}
export board_dir=${test_dir}/qemu/arm/${board}/${kernel_ver}

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

if [ "$arch" == "arm" ] ;then
    export compile_tools_dir="${toolchains_dir}/${compile_tools}/bin"
    export params=" ARCH=$arch CROSS_COMPILE=arm-linux-gnueabi- "
    if isexist $PATH ${compile_tools_dir}; then
        echo "${compile_tools_dir} already in path"
    else
        export PATH=${compile_tools_dir}:$PATH
    fi

elif [ "$arch" == "x86_64" ] ;then
    export compile_tools_dir=""
    export params=" "
else

    export compile_tools_dir="${toolchains_dir}/${compile_tools}/bin"
    export params=" ARCH=$arch CROSS_COMPILE=arm-linux-gnueabi- "
    if isexist $PATH ${compile_tools_dir}; then
        echo "${compile_tools_dir} already in path"
    else
        export PATH=${compile_tools_dir}:$PATH
    fi
fi

if [ "$1" == "modules" ] ;then

    make $params modules -j2 O=$output

    if [ ! -d "${board_dir}/img" ]; then
        mkdir -p ${board_dir}/img
    fi

    if [ ! -f "${board_dir}/vexpress.img" ]; then
        cp -f ${board_dir}/../backup/vexpress.img ${board_dir}
    fi

    cd $output

    sudo mount -o loop,offset=$((2048*512)) ${board_dir}/vexpress.img ${board_dir}/img
    sudo make $params modules_install INSTALL_MOD_PATH=${board_dir}/img
    sudo umount ${board_dir}/img

else

    make $params $cfgfile O=$output
    make $params O=$output -j2 zImage dtbs 
    make $params O=$output -j2 uImage LOADADDR=${loadaddr}
    make $params modules -j2 O=$output

    echo ""
    echo "Copy zImage uImage dtb .config to ${board_dir}"
    echo ""
    
    if [ ! -d "$board_dir" ]; then
      mkdir -p "$board_dir"
    fi

    cp $output/arch/arm/boot/zImage $board_dir/
    cp $output/arch/arm/boot/uImage $board_dir/
    cp $output/arch/arm/boot/dts/*ca9.dtb  $board_dir/
    cp $output/.config $board_dir/

fi

