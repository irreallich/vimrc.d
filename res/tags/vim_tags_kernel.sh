#!/bin/bash


ycmfile=".ycm_extra_conf.py"
if [ ! -f $ycmfile ]; then
    cp ${config_dir}/vimrc.d/res/ycm_config/ycm_extra_conf_kernel.py $ycmfile
fi

gutctags=".gutctags"
if [ ! -f $gutctags ]; then
cat>$gutctags<<EOF
--languages=c,c++

--exclude=arch
--exclude=crypto
--exclude=drivers
--exclude=firmware
--exclude=include
--exclude=ipc
--exclude=lib
--exclude=net
--exclude=scripts
--exclude=sound
--exclude=usr
--exclude=block
--exclude=Documentation
--exclude=extra
--exclude=fs
--exclude=init
--exclude=kernel
--exclude=mm
--exclude=samples
--exclude=security
--exclude=tools
--exclude=virt

-L .ctagsfiles
EOF
fi

ctagsfiles=".ctagsfiles"
if [ ! -f $ctagsfiles ]; then
    rg --files kernel include mm lib firmware init scripts virt ipc block usr  > $ctagsfiles
    rg --files fs >> $ctagsfiles
    rg --files net >> $ctagsfiles
    
    #rg --files tools       >> $ctagsfiles
    #rg --files simples     >> $ctagsfiles
    #rg --files security    >> $ctagsfiles
    #rg --files crypto      >> $ctagsfiles
    #rg --files tools       >> $ctagsfiles
    

    # 以下针对sound
    # rg --files sound       >> $ctagsfiles


    # 以下针对驱动
    rg --files drivers/base >> $ctagsfiles


    # 以下针对不同的平台
    rg --files arch |grep -w "arch/arm" |grep -v mach* |grep -v  plat* |grep -v ".dts" >> $ctagsfiles
    rg --files arch/arm/mach-vexpress  >> $ctagsfiles

fi


