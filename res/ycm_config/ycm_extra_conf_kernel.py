# .ycm_extra_conf.py for linux kernel
import os
import subprocess
import glob

NAME = 'ycm4linux'

CODE_MODE = 'embedded'
#CODE_MODE = 'pc'




if CODE_MODE == 'pc':
    KARCH = os.environ.get('KARCH')
    # 设置KDIR到源代码目录，不设置的话目录为/lib/modules/`uname -r`/build
    # 获得环境变量KDIR指明的目录
    KDIR = os.environ.get('KDIR')
    if not KDIR:
        KERNEL_RELEASE = subprocess.check_output(['uname', '-r']).decode('utf-8').strip()
    KDIR = '/lib/modules/' + KERNEL_RELEASE + '/build/'
    # 设置gcc的路径
    GCCPATH = subprocess.check_output(['gcc', '-print-file-name=']).decode('utf-8').strip()
else:
    # 设置kernel编译的平台
    KARCH = 'arm'
    # 获得当前脚本文件所在的目录
    KDIR = os.path.split(os.path.realpath(__file__))[0]
    # 设置gcc的路径
    GCCPATH = '/home/hjwang/work/src/projects/learn_drv/toolchains/gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabi/lib/gcc/arm-linux-gnueabi/4.9.4'

if not KARCH:
    KARCH = 'x86'
if not os.path.isdir(KDIR):
    raise Exception(NAME + ': could not find kernel headers at ' + KDIR)
if not os.path.isdir(GCCPATH):
    raise Exception(NAME + ': could not find GCC installation at ' + GCCPATH)

# Flags determined through a verbose build of a simple kernel module.
flags = [
    # Define your per project flags here, flags starting with '.' will be expanded

    # Language flags
    '-xc',
    '-std=gnu89',
    # Defines
    '-D__KERNEL__',
    '-DMODULE',
    '-include', KDIR + '/include/linux/kconfig.h',
    # Include paths
    '-nostdinc',
    '-isystem', GCCPATH + '/include',
    '-I', KDIR + '/arch/' + KARCH + '/include',
    '-I', KDIR + '/arch/' + KARCH + '/include/generated/uapi',
    '-I', KDIR + '/arch/' + KARCH + '/include/generated',
    '-I', KDIR + '/include',
    '-I', KDIR + '/arch/' + KARCH + '/include/uapi',
    '-I', KDIR + '/include/uapi',
    '-I', KDIR + '/include/generated/uapi',
    # Warning flags
    '-Wall',
    '-Wundef',
    '-Wstrict-prototypes',
    '-Wno-trigraphs',
    '-fno-strict-aliasing',
    '-fno-common',
    '-Werror-implicit-function-declaration',
    '-Wno-format-security',
    '-Wdeclaration-after-statement',
]

def getExpandedFlags():
    wd = os.path.dirname(os.path.abspath(__file__))
    ret = []
    for flag in flags:
        if flag.startswith('.'):
            ret.append(os.path.join(wd, flag))
        else:
            ret.append(flag)
    return ret
print(getExpandedFlags())

def FlagsForFile(filename):
    return {
        'flags': getExpandedFlags(),
        'do_cache': True
    }

