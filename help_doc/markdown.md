# Markdown规范

本文主要对《了不起的Markdown》进行一些整理, 把规范和推荐排版记录一下以供参考

- [Markdown规范](#markdown规范)
    - [1 排版](#1-排版)
        - [1.1 推荐排版结构](#11-推荐排版结构)
    - [2 基础语法](#2-基础语法)
        - [2.1 标题](#21-标题)
        - [2.2 粗体和斜体](#22-粗体和斜体)
        - [2.3 段落与换行](#23-段落与换行)
        - [2.4 列表](#24-列表)
        - [2.5 分隔线](#25-分隔线)
        - [2.6 图片](#26-图片)
        - [2.7 超链接](#27-超链接)
        - [2.8 行内代码与代码块](#28-行内代码与代码块)
        - [2.9 引用](#29-引用)
        - [2.10 转义](#210-转义)
    - [3 扩展语法GFM](#3-扩展语法gfm)
        - [3.1 删除线](#31-删除线)
        - [3.2 表情符号](#32-表情符号)
        - [3.3 自动链接](#33-自动链接)
        - [3.4 表格](#34-表格)
        - [3.5 任务列表](#35-任务列表)
        - [3.6 围栏代码块](#36-围栏代码块)
        - [3.7 锚点](#37-锚点)
    - [4 其他排版](#4-其他排版)

## 1 排版

### 1.1 推荐排版结构
```markdown
# 文档标题

作者

摘要

目录

## 标题1

### 标题1.1

## 标题2

### 标题2.1

### 标题2.2
```

## 2 基础语法

### 2.1 标题

标题可以使用`#或底线`标记, **# 支持6级标题, 底线只支持 `=` 1级和 `-` 二级标题**

- 使用 `#` 而非底线
- 标题前后空1行, `#` 与标题之间1个空格
- 结尾不要有标点符号
- 简约

### 2.2 粗体和斜体

粗体和斜体可以使用`*或_`标记

- 使用 `*` 而非 `_`
- `*` 之间不要有空格

### 2.3 段落与换行

有 1 和 2 段落, 如要将其视为不同段落, **写法 1:** `空格换行, 段落间空1行;` **写法 2:** `段内换行, 段落间插入2个以上空格且有一个回车;`

- 超过 80 字符换行
- 一句话结束 ( 。！？) 时换行
- 当 URL 较长时文字与 URL 间换行, 推荐使用段内换行, 或使用引用链接优化

### 2.4 列表

列表分为有序和无序, 有序: `数字序号 + 英文句号 + 空格 + 列表内容;` 无序: `*/+/- + 空格 + 列表内容;`嵌套列表: `下一级列表行首比当前行行首多1Tab`

- \- 标记无序列表
- 如列表中没有换行项
    - 同级项空格数: 无序列表3空格, 有序列表2空格
    - 同级项间不要有空行
- 如列表中有换行项
    - 同级项空格数: 1 空格
    - 同级项间空一行

### 2.5 分隔线

分割线由一行至少3个以上`*/-/_`标记, 可在标记符中间加空格

### 2.6 图片

图片由: `![404时替代文字](图片地址)`组成

### 2.7 超链接

超链接在分为**文字链接**和它的解耦写法**引用链接**, 以及网址链接, 网址链接语法: `<网址>`; 文字链接语法: `[链接文字](链接地址)`; 引用链接语法如下: 
```markdown
引用链接: 定义上面必须要有1空行
调用
本文参考: [XXX文章]
定义

[XXX文章]: https://blog.wars.cat/xxxxx
```

- 文字链接使用有意义的标题
- 用 `<>` 包裹自动链接
- 自动链接以 http/https 开头

### 2.8 行内代码与代码块

行内代码语法: \`包裹代码; 代码块语法: `以Tab或4个空格开头`; 但是由于原生代码块语法不够直观, 扩展语法几乎都提供了围栏代码块语法如下: 

```markdown
`` `python
// `中间去掉空格
def print_name():
    print("Markdown")
`` `
```

- 针对与 Shell类型代码, 在有输出内容时加上 $, 反之不加

### 2.9 引用

引用语法: `> 引用内容`, > 可嵌套使用

- \> 后添加一个空格
- 多行引用每一行都使用符号 >
- 不要引用空行

### 2.10 转义

转义语法: `\转义符号`

- - - - - - - - - -

## 3 扩展语法GFM

GFM(Github Flavored Markdown)

### 3.1 删除线

删除线语法: `~~内容~~`, 只有两个 `~`

### 3.2 表情符号

表情符号语法: `:表情代码:`, 只有一个 `:`, 支持emoji表情

### 3.3 自动链接

GFM化简了标准语法的 <> 链接，无需括号包裹，**规范请带上括号**

### 3.4 表格

表格语法: 
```markdown
# 不推荐写法
表头|表头2|表头3
:---|---|---:
 1 | 2 | 3

# 推荐写法

| 表头 | 表头2 | 表头3 |
| :---- | :----: | ----: |
| 左对齐(def) | 居中对齐 | 居右对齐 |

```
- 表格前后空一行
- 每行首尾使用 |
- 不要使用庞大表格, 难以维护

### 3.5 任务列表

任务列表语法: `- [x/空格]`，可嵌套，如:

```markdown
- [x] 拖地
    - [ ] 煮饭
```

### 3.6 围栏代码块

围栏代码块语法：3个 ` 或 ~ 的行括住, 如需语法高亮，首3符号后加上语法名

- 围栏代码块被空行包裹

### 3.7 锚点

锚点语法：`[锚点描述](#锚点名)`，如调用的锚点名中包含空格，可用 `-` 代替

## 4. 其他排版

**善用空格**

