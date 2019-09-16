fwhich  查看命令 文件的位置

定义变量使用$符号

定义变量时 = 前后不能有空格    有空格  会当做命令

a=11

echo $a  ==> 11

单双引号区别

echo '$a' ==>$a  

echo "$a" ==>11

whoami  检查自身

echo   $?   检查程序运行后的状态码

echo  -e  使\n正常使用

printf  正常使用  换行在引号后面再加一个\n

export  A=45  定义全局变量

expr    运算

echo $[ $a  *  $b ]        运算       前后各有一个空格   测试命令  []

双层[] 之间不需要加空格

. = source   把一个函数写在另外一个文件时  想要在当前文件中执行时使用

$*  $@ 都是匹配所有的参数

$#  标记一个参数或其他的数量

## shell脚本

#### 简述

- shell脚本是开发者和运维人员为了方便  快捷 维护大量服务器 操作的文件
- shell脚本是以 .sh 结尾的文本文件  .sh是扩展名 可省略
- #脚本注释
- 脚本首行     #!  表示使用哪种程序来执行脚本  引导作用
  - #!/bin/sh
  - #!/bin/bash
  - #!/usr/bin/env bash

#### 脚本的创建

- 先创建一个文件  touch test.sh
- 将文本写入test.sh中

~~~
#!/bin/bash
echo "Hello"
echo "I am `whoami`"
echo "I love Linux"
echo "The CPU in my PC has `cat /proc/cpuinfo |grep -c processor` cores"
exit 0
~~~

- 对脚本授予权限    执行:chmod 755 test.sh    
- 输入 ./test.sh  执行脚本
- 查看脚本的退出状态: echo $?
  - linux中所有的程序执行结束后都有状态码
  - 状态码为0表示正常,为整数表示异常

## 变量

- 赋值时  =  前后不能有空格   在linux中  有空格会被看做命令

~~~
a=45
~~~

- 使用  :在变量名前面加$符号

~~~
echo "---$a---\n===$b==="
printf "---$a---\n===$b===\n"
~~~

注意: ' $a' 不会解析  ===>$a

​         " $a" 会被解析 ===>45

- 定义当前shell下的全局变量
  - 定义:export ABC=9876543210123456789
  - 定义完后,在终端里用source加载脚本 :source ./test.sh
  - .  和source作用相同

- 常用的系统环境变量
  - $PATH : 可执行文件目录
  - $PWD : 当前目录
  - $HOME : 家目录
  - $USER : 当前用户名
  - $UID : 当前用户的 uid\

## 分支语句:if

格式:

~~~
if command
then 
   command
elif command
then
	command
fi	
~~~

- if 语句检查判断依据 :看后面所跟命令的状态码0为true,其余为false

~~~
if ls /xxx
then
echo 'exist xxx'
else
echo 'not exist xxx'
fi
~~~

- 条件测试命令: [ ... ]

  - [] 是一个命令,里面条件是参数,且内容前后要有空格  否则会报错

  - [[ ... ]]

  - 比较

    - 数值比较
    - 字符串比较
    - 文件比较

  - 用法:

    ~~~
    if [ condition ]
    then
    	commands
    fi
    ~~~

- 条件列表

  - 数值比较
    - -eq   -ge  -gt   -le  -lt  -ne
  - 字符串比较
    - =     !=    <    > 
    - -nstr1      检查str1的⻓度是否非0
    - -z str1       检查str1的⻓度是否为0
    - [[ $a > $b ]] >要放在中括号中  或者使用/  不然会被当成重定符
  - 文件比较
    - -d file 检查file是否存在并是一个目录
    - -e file 检查file是否存在    -exist
    - -f file 检查file是否存在并是一个文件
    - -r file 检查file是否存在并可读
    - -w file 检查file是否存在并可写
    - -x file 检查file是否存在并可执行
    - -s file 检查file是否存在并非空
    - -O file 检查file是否存在并属当前用户所有
    - -G file 检查file是否存在并且默认组与当前用户相同
    - file1 -nt  file2 检查file1是否比file2新
    - file1 -ot  file2 检查file1是否比file2旧

## for循环

循环结构 :for;  while;  until

- for 循环   

~~~
for 变量 in 序列 
do
要执行的命令
done
do done  一起1出现
~~~

- 

## 函数

- 定义  function  (可省略)

~~~
function foo() {
echo "---------------------------"
echo "Hello $1, nice to meet you!"
echo "---------------------------"
}
~~~

- 使用
  - 在终端或脚本中直接输入函数名即可
  - 传参也只需将参数加到函数名后面,以空格做间隔

  ~~~
  foo arg1 arg2 arg3 .....
  ~~~

  

- 参数

~~~
bar() {
echo "执行者是 $0"
echo "参数数量是 $#"
echo "全部的参数 $@"
echo "全部的参数 $*"
if [ -d $1 ]; then
# 检查传入的第一一个参数是否是文件夹
for f in `ls $1`
do
echo $f
done
elif [ -f $1 ]; then
echo 'This is a file: $1' # 单引号内的变量不不会被识别
echo "This is a file: $1" # 如果不是文件夹, 直接显示文件名
else
echo 'not valid'
fi
}
~~~

## 获取用户输入

~~~
read -p "请输入一个数字:" num
echo "您输入的是:$num"
-p 引导符
~~~

