# -*- coding=utf8 -*-
"""
# Author: WangHongjie
# Created Time : 2019/5/10 17:11:00
# File Name: .ycm_extra_conf.py
# Description:
    用于配置ycm的python virtual env补全功能
    使用方法：
    将此文件copy到python的工程目录中，修改interpreter_path的值为python virtual env目录

    存在的问题：
    如果工作的python版本和vim以及相应编译的版本不一致，则会出现以下两种情况
    1. 如果vim为x86而ycm使用x64编译或者反之，则ycm无法启动
    2. 如果vim和ycm都是x64但是开发代码使用x86环境python，则跳转会到x64的代码中
    结论：尽量让所开发的代码的运行环境和vim以及ycm的环境相同
"""
import os
import os.path as p
import sys
import site
import platform

script_path = p.abspath( p.dirname( __file__ ) )
home_path = p.abspath(p.dirname("$HOME"))

def Settings( **kwargs ):
    # inter_path也可以是其他位置
    sys_path = []
    if platform.system() == 'Windows':
        #默认位置
        interp_path=sys.executable 
        sys_path += site.getusersitepackages()
        sys_path += site.getsitepackages()
    elif platform.system() == 'Linux':
        #默认位置
        interp_path=sys.executable 
        sys_path += site.getusersitepackages()
        sys_path += site.getsitepackages()
    else:
        return {}
    return {
        'interpreter_path': interp_path,
        'sys_path': sys_path
    }

