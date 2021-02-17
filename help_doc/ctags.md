# ctags 在vim中使用简单记录

## 针对linux c语言
- 通过 help tags可以看到具体介绍
- 使用命令set tag=tag文件的位置以及名字，就可以将tag文件加入到vim中
  tags有一个小技巧，在vimrc文件中set tags=tags; (注意有分号)，在vi中使用定位快捷键时会先在当前目录中查找tags文件，找不到的话，就会到父目录中找，依次类推，这样 你在编辑一个大工程时，只需要在最上一层建立一个tags文件，之后可以任意切换到工程子目录里去操作！
- 设置好tag文件位置后，vim可以找到建立的tag文件的话，就可以通过类似下面命令跳转位置,对c语言非常有用
  - <c-]> 跳转到函数定义
  - <c-t> 跳转回来

## 建立tag文件的办法
### 例子
如下命令是生成包含 ubuntu里的包含`/usr/include`和`/usr/local/includ`目录下的c语言函数声明的tag文件，并将其保存为 ./ubuntu_1804_systags中
```
ctags --fields=+iaS --extras=+q -R -f ./ubuntu_1804_systags /usr/include /usr/local/include
```
生成tag文件后可以通过如下命令将其加入vim
set tags+= ./ubuntu_1804_systags,此时tag命令就可以使用了

### 建立tag 
普通方法
    ctags --fields=+iaS --extras=+q -R -f ./ubuntu_1804_systags /usr/include /usr/local/include

获得全面的tags，包括绝大多数声明,可能获得的太多
    __THROW的宏定义让ctags不再认为该系列函数是函数, -I __THROW 可以忽略此问题
    同时此命令还能忽略 attribute_pure ，nonull等属性，如果需要#if 0里面的定义，可以–if0=yes来忽略 #if 0这样的定义
    ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f ./ubuntu_1804_systags /usr/include /usr/local/include

简化tags，将-R去掉不做递归，自己指定目录,注意不能缺少后面的* 
    ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q  -f ~/.vim/systags /usr/include/* /usr/include/sys/* /usr/include/bits/*  /usr/include/netinet/* /usr/include/arpa/* /usr/include/mysql/*




