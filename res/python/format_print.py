#!/usr/bin/env python
# -*- coding=utf8 -*-
"""
# Author: hjwang
# Created Time : 2019年11月17日 星期日 19时33分00秒
# File Name: format_print.py
# Description:
"""

import sys

def __create_spaces(lvl):
    spaces = ''
    tab = '    '
    for i in range(lvl-1):
        spaces = spaces + tab
    return spaces

def __print(obj,end='\n'):
    if isinstance(obj,str):
        obj = obj.encode('u8')
    if isinstance(obj,str):
        sys.stdout.write(obj+end)
    else:
        print(obj),
        sys.stdout.write(end)

def format_print(obj,lvl=0,indict=False,islast=True):
    lvl = lvl + 1 
    spaces = __create_spaces(lvl)
    index = 0

    if isinstance(obj,list):
        if not indict:
            __print(spaces,end='')
        __print('[')
        for item in obj:
            if index+1 < len(obj):
                format_print(item,lvl,islast=False)
            else:
                format_print(item,lvl)
            index = index + 1
        __print(spaces + ']',end='')
        if islast:
            __print('')
        else:
            __print(',')

    elif isinstance(obj,tuple):
        if not indict:
            __print(spaces,end='')
        __print('(')
        for item in obj:
            if index+1 < len(obj):
                format_print(item,lvl,islast=False)
            else:
                format_print(item,lvl)
            index = index + 1
        __print(spaces + ')',end='')
        if islast:
            __print('')
        else:
            __print(',')

    elif isinstance(obj,set):
        if not indict:
            __print(spaces,end='')
        __print('set(')
        for item in obj:
            if index+1 < len(obj):
                format_print(item,lvl,islast=False)
            else:
                format_print(item,lvl)
            index = index + 1
        __print(spaces + ')',end='')
        if islast:
            __print('')
        else:
            __print(',')

    elif isinstance(obj,dict):
        __print(spaces + '{')
        for key in obj:
            __print(__create_spaces(lvl+1)+str(key) + ': ',end='')
            if index+1 < len(obj):
                format_print(obj[key],lvl,indict=True,islast=False)
            else:
                format_print(obj[key],lvl,indict=True)
            index = index + 1
        __print(spaces + '}',end='')
        if islast:
            __print('')
        else:
            __print(',')

    else:
        if not indict:
            __print(spaces,end='')
        __print(obj,end='')
        if islast:
            __print('')
        else:
            __print(',')



if __name__ == '__main__':
    obj1 = {
        'data':[
            {
            'data_id':'1',
            'content':'西红柿'
            },
            {
            'data_id':'2',
            'content':'胡萝卜'
            }
        ],
        'name':'蔬菜',
        'id':1,
    }
    print(obj1)
    print('\n')
    import pprint
    pprint.pprint(obj1)
    print('\n')
    format_print(obj1)
