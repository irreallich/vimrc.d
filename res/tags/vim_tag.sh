#!/bin/bash


ycmfile=".ycm_extra_conf.py"
if [ ! -f $ycmfile ]; then
    cp ${CONFIG_DIR}/vimrc.d/res/ycm_config/ycm_extra_conf_cpp.py $ycmfile
fi

gutctags=".gutctags"
if [ ! -f $gutctags ]; then
cat>$gutctags<<EOF
--languages=c,c++
--skip-symlink

--exclude=submodule
--exclude=module
--exclude=output
--exclude=thirdparty_linux-aarch64

-L .ctagsfiles
EOF
fi

ctagsfiles=".ctagsfiles"
if [ ! -f $ctagsfiles ]; then
    rg --files module submodule  > $ctagsfiles
fi


