" VIM scripts
" Author: hjwang
" Created Time : 2019年08月23日 星期五 16时11分57秒
" File Name: config/plug_conf/vim_clang_format.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['rhysd/vim-clang-format'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_clang_format'],
            \}
function! Pluginfo_vim_clang_format()
    return s:pluginfo 
endfunction

function! Init_vim_clang_format()
    call Vim_clang_format_init()            
endfunction 

function! Vim_clang_format_init()
    " for llvm , ref  http://clang.llvm.org/docs/ClangFormatStyleOptions.html
    let g:clang_format#code_style='llvm'
    let g:clang_format#style_options = {}
    let g:clang_format#style_options.TabWidth = 4 
    let g:clang_format#style_options.UseTab = 'Never'
    let g:clang_format#style_options.IndentWidth = 4  
    let g:clang_format#style_options.IndentPPDirectives = 'BeforeHash'  
    let g:clang_format#style_options.AccessModifierOffset = -4 
    let g:clang_format#style_options.BreakBeforeBraces = 'Allman'   
    let g:clang_format#style_options.AllowShortIfStatementsOnASingleLine = 'false'  
    let g:clang_format#style_options.IndentCaseLabels = 'true'   
    let g:clang_format#style_options.AllowShortFunctionsOnASingleLine = 'false'  
    let g:clang_format#style_options.AlignConsecutiveDeclarations = 'true'  
    let g:clang_format#style_options.AlignConsecutiveMacros = 'true' 
    let g:clang_format#style_options.AlignTrailingComments = 'true' 
    let g:clang_format#style_options.BinPackArguments = 'false'  
    let g:clang_format#style_options.BinPackParameters = 'false'
    let g:clang_format#style_options.ColumnLimit = '90'  
    let g:clang_format#style_options.Standard = 'C++11'  
    let g:clang_format#style_options.AlignEscapedNewlines = 'Right'  
    let g:clang_format#style_options.AlignConsecutiveAssignments = 'true' 
endfunction

function! Vbackup_func()
    let g:clang_format#code_style='llvm'
    let g:clang_format#style_options = {
    \ "TabWidth" : 4,
    \ "UseTab" : 'Never',
    \ "IndentWidth" : 4,
    \ "IndentPPDirectives" : 'BeforeHash',
    \ "AccessModifierOffset" : -4,
    \ "AllowShortIfStatementsOnASingleLine" : 'false',
    \ "IndentCaseLabels" : 'true',
    \ "AlignConsecutiveDeclarations" : 'true',
    \ "AlignConsecutiveMacros" : 'true',
    \ "AlignTrailingComments" : 'true',
    \ "BinPackArguments" : 'false' ,
    \ "BinPackParameters" : 'false',
    \ "ColumnLimit" : 80,
    \ "Standard" : 'C++11',
    \ "AlignEscapedNewlines" : 'Right',
    \ "AlignConsecutiveAssignments" : 'true',
    \ "AlignAfterOpenBracket" : 'DontAlign',
    \ "BreakBeforeBraces" : 'Custom',
    \ }

    "\ "PPDirectiveIndentStyle" : 'None',
    
    "let g:clang_format#style_options.BreakBeforeBraces = 'Allman'   
    if g:clang_format#style_options.BreakBeforeBraces == 'Custom'
        "手动设置大括号之前的换行
        let g:clang_format#style_options.BraceWrapping = {
        \ "AfterClass" : 'true',
        \ "AfterControlStatement" : 'true',
        \ "AfterEnum" : 'true',
        \ "AfterFunction" : 'true',
        \ "AfterNamespace" : 'true',
        \ "AfterObjCDeclaration" : 'true',
        \ "AfterStruct" : 'true',
        \ "AfterUnion" : 'true',
        \ "AfterExternBlock" : 'true',
        \ "BeforeCatch" : 'true',
        \ "BeforeElse" : 'true',
        \ "IndentBraces" : 'false',
        \ "SplitEmptyFunction" : 'false',
        \ "SplitEmptyRecord" : 'false',
        \ "SplitEmptyNamespace" : 'false',
        \ }
    endif
endfunction
"        \ 'NamespaceIndentation' : 'Inner',

"    # 语言: None, Cpp, Java, JavaScript, ObjC, Proto, TableGen, TextProto
"    Language:        ObjC
"    # 访问说明符(public、private等)的偏移
"    AccessModifierOffset: -4
"    # 连续赋值时，等号对齐
"    AlignConsecutiveAssignments: true
"    # define 换行时反斜杠位置：左对齐
"    AlignEscapedNewlines: Left
"    # 连续代码的尾部注释对齐
"    AlignTrailingComments: true
"    # 允许短代码块放在同一行 if 1 { return; }
"    AllowShortBlocksOnASingleLine: false
"    # 允许短的case标签放在同一行
"    AllowShortCaseLabelsOnASingleLine: false
"    # 允许短的函数放在同一行
"    AllowShortFunctionsOnASingleLine: All
"    # 允许短的if语句保持在同一行
"    AllowShortIfStatementsOnASingleLine: false
"    # 允许短的循环保持在同一行
"    AllowShortLoopsOnASingleLine: false
"    # 总是在返回类型后换行
"    AlwaysBreakAfterReturnType: None
"    # 总是在多行string字面量前换行
"    AlwaysBreakBeforeMultilineStrings: false
"    # 总是在template声明后换行
"    AlwaysBreakTemplateDeclarations: MultiLine
"    # false表示函数实参要么都在同一行，要么都各自一行
"    BinPackArguments: false
"    # false表示所有形参要么都在同一行，要么都各自一行
"    BinPackParameters: false
"    # 在大括号前换行: Attach(始终将大括号附加到周围的上下文), Linux(除函数、命名空间和类定义，与Attach类似), 
"    #   Mozilla(除枚举、函数、记录定义，与Attach类似), Stroustrup(除函数定义、catch、else，与Attach类似), 
"    #   Allman(总是在大括号前换行), GNU(总是在大括号前换行，并对于控制语句的大括号增加额外的缩进), WebKit(在函数前换行), Custom
"    #   注：这里认为语句块也属于函数
"    BreakBeforeBraces: Custom
"    # 大括号换行，只有当BreakBeforeBraces设置为Custom时才有效
"    BraceWrapping:
"      # class定义后面   
"      AfterClass:      false
"      # 控制语句后面
"      AfterControlStatement: false
"      # enum定义后面
"      AfterEnum:       false
"      # 函数定义后面（OC 无效） 
"      AfterFunction:   true
"      # 命名空间定义后面
"      AfterNamespace:  false
"      # OC 定义后面
"      AfterObjCDeclaration:  false
"      # struct定义后面
"      AfterStruct:     false
"      # union定义后面
"      AfterUnion:      false
"      # entern定义后面
"      AfterExternBlock: false
"      # catch之前
"      BeforeCatch:     false
"      # else之前
"      BeforeElse:      false
"      # 缩进大括号
"      IndentBraces:    false
"      #false 时，空方法体 {} 放在一行
"      SplitEmptyFunction: true
"      #false 时，空记录（例如，类，结构或联合）{} 放在一行
"      SplitEmptyRecord: true
"      # false 且 AfterNamespace == true 时 空命名空间体可放到一行: {}
"      SplitEmptyNamespace: true
"    # 在二元运算符前换行: None(在操作符后换行), NonAssignment(在非赋值的操作符前换行), All(在操作符前换行)  
"    BreakBeforeBinaryOperators: All
"    # 三元运算符 true 符号前换行 false 符号后换行
"    BreakBeforeTernaryOperators: true
"    # 继承时 BeforeColon ‘：’前换行
"    BreakInheritanceList: BeforeColon
"    # 在构造函数的初始化列表的逗号前换行
"    BreakConstructorInitializers: BeforeComma
"    # 在Java文件中的字段上的每个注释之后中断。
"    BreakAfterJavaFieldAnnotations: false
"    # Allow breaking string literals when formatting.
"    BreakStringLiterals: true
"    # 每行字符的限制，0表示没有限制
"    ColumnLimit:     0
"    # 描述具有特殊意义的注释的正则表达式，它不应该被分割为多行或以其它方式改变
"    CommentPragmas:  '^ IWYU pragma:'
"    # true，连续的名称空间声明将位于同一行。如果为false，则在新行上声明每个名称空间。
"    CompactNamespaces: false
"    # 构造函数的初始化列表要么都在同一行，要么都各自一行
"    ConstructorInitializerAllOnOneLineOrOnePerLine: false
"    # 构造函数的初始化列表的缩进宽度
"    ConstructorInitializerIndentWidth: 4
"    # 延续的行的缩进宽度
"    ContinuationIndentWidth: 4
"    # 去除C++11的列表初始化的大括号{后和}前的空格
"    Cpp11BracedListStyle: false
"    # 继承最常用的指针和引用的对齐方式
"    DerivePointerAlignment: false
"    # 关闭格式化
"    DisableFormat:   false
"    # 自动检测函数的调用和定义是否被格式为每行一个参数(Experimental)
"    ExperimentalAutoDetectBinPacking: false
"    # true 自动检测补全命名空间尾部的大括号
"    FixNamespaceComments: false
"    # 需要被解读为foreach循环而不是函数调用的宏
"    ForEachMacros:   
"      - foreach
"      - Q_FOREACH
"      - BOOST_FOREACH
"    # #include 分组排序方式 Preserve(按组排序) Merge（合并成一组排序）Regroup（按 IncludeCategories 重新分组排序）
"    IncludeBlocks:   Preserve
"    IncludeCategories: 
"      - Regex:           '^"(llvm|llvm-c|clang|clang-c)/'
"        Priority:        2
"      - Regex:           '^(<|"(gtest|gmock|isl|json)/)'
"        Priority:        3
"      - Regex:           '.*'
"        Priority:        1
"    # Specify a regular expression of suffixes that are allowed in the file-to-main-include mapping.
"    IncludeIsMainRegex: '(Test)?$'
"    # case 是否缩进一级
"    IndentCaseLabels: true
"    # 预处理代码缩进样式。None（不缩进）AfterHash（缩进）
"    IndentPPDirectives: None
"    # 缩进宽度
"    IndentWidth:     4
"    # 函数在返回类型后换行，是否缩进函数名
"    IndentWrappedFunctionNames: false
"    # JS 引号样式 Leave("",'') Single("") Double("")
"    JavaScriptQuotes: Leave
"    # JS import 是否需要换行
"    JavaScriptWrapImports: true
"    # 保留在块开始处的空行(OC 没用)
"    KeepEmptyLinesAtTheStartOfBlocks: true
"    # 开始一个块的宏的正则表达式
"    MacroBlockBegin: ''
"    # 结束一个块的宏的正则表达式
"    MacroBlockEnd:   ''
"    # 连续最大空行数
"    MaxEmptyLinesToKeep: 1
"    # 命名空间的缩进: None, Inner(缩进嵌套的命名空间中的内容), All
"    NamespaceIndentation: Inner
"    # OC 协议根据 ColumnLimit 长度 换行
"    ObjCBinPackProtocolList: Auto
"    # 使用 OC block 函数实现内部缩进宽度
"    ObjCBlockIndentWidth: 4
"    # 在ObjC的@property后添加一个空格
"    ObjCSpaceAfterProperty: true
"    # 在OC的protocol列表前添加一个空格
"    ObjCSpaceBeforeProtocolList: true
"    PenaltyBreakAssignment: 2
"    PenaltyBreakBeforeFirstCallParameter: 19
"    PenaltyBreakComment: 300
"    PenaltyBreakFirstLessLess: 120
"    PenaltyBreakString: 1000
"    PenaltyBreakTemplateDeclaration: 10
"    PenaltyExcessCharacter: 1000000
"    PenaltyReturnTypeOnItsOwnLine: 60
"    # 指针和引用的对齐: Left（int* a;）, Right（int *a;）, Middle（int * a;）
"    PointerAlignment: Right
"    # 允许重新排版注释
"    ReflowComments:  true
"    # 允许排序#include,首字母排序
"    SortIncludes:    true
"    # true using 自动排序
"    SortUsingDeclarations: false
"    # 在C风格类型转换后添加空格
"    SpaceAfterCStyleCast: false
"    # template 关键字后添加空格
"    SpaceAfterTemplateKeyword: true
"    # false 移除 = +=  两侧的空格
"    SpaceBeforeAssignmentOperators: true
"    # 初始化 c++ 11 对象的前面空格
"    SpaceBeforeCpp11BracedList: true
"    # 构造函数：前加空格
"    SpaceBeforeCtorInitializerColon: true
"    # 继承的：前面加空格
"    SpaceBeforeInheritanceColon: true
"    # 开圆括号之前添加一个空格: Never, ControlStatements, Always
"    SpaceBeforeParens: ControlStatements
"    # false 清除 for 循环:前面的空格 for (auto v : values) {} 
"    SpaceBeforeRangeBasedForLoopColon: true
"    # 在空的圆括号中添加空格
"    SpaceInEmptyParentheses: false
"    # 在尾随的评论前添加的空格数(只适用于//)
"    SpacesBeforeTrailingComments: 1
"    # 在尖括号内部前后添加空格 < int >
"    SpacesInAngles:  false
"    # 快捷数组 内部加空格 [ 1, 2, 3 ]; ：前加空格 f({a : 1, b : 2, c : 3});
"    SpacesInContainerLiterals: false
"    # 在C风格类型转换的括号中添加空格
"    SpacesInCStyleCastParentheses: false
"    # 在圆括号的(后和)前添加空格
"    SpacesInParentheses: false
"    # 在方括号的[后和]前添加空格，lamda表达式和未指明大小的数组的声明不受影响
"    SpacesInSquareBrackets: false
"    # 标准: Cpp03, Cpp11, Auto
"    Standard:        Cpp11
"    # tab宽度
"    TabWidth:        4
"    UseTab:          Never
"    
