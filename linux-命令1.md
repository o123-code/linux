# linux-命令1

## 下载

apt或apt-get

yum

## bash快捷键

- ctrl + alt + t   快速打开终端
- ctrl + shift + c复制
- ctrl +shift + v 粘贴
- ctrl + shift +t 新建工作区
- ctrl + shift  +j 纵向分屏
- ctrl+shift + h 横向分屏
- ctrl+shift+q 删除多余分屏
- ctl + f 前进一个字符 
- ctl + b 后退一个字符
- ctl + a 回到行首
- ctl + e 回到行尾
- ctl + w 向左删除一个单词
- ctl + u 向左删除全部
- ctl + k 向右删除全部
- ctl + y 粘贴上次删除的内容
- ctl + l 清屏

## 基本操作

man  查看各个东西的文档   man  cat......

- cd  进入  eg：cd  /boot/groub/
- cd  ../../../....   返回上一级.....
- cd  /  、  cd  ~  回到根目录
- cd -    切换
- cat /tac/nl + 文件名   可以查看文件内容/目录是否存在
  - cat 正向列出
  - tac 反向列出
  - nl  列出时给出行号
- od  [-t type]  文件   读取非纯文本文件
- pwd   查看当前目录\文件的路径
- men 内存
- net 网络方面
- bus主线
- echo  'abcd'  在屏幕上打印字符串   >写一个文件  >>  追加
- up键 重复上面命令
- mv   
  - 移动    可改名
  - mv   zzz  ppp      zzz会被覆盖
- mv -i ppp  zzz   -i询问 -n不覆盖 -f 强制覆盖   
- cp  拷贝

## 目录结构

/    系统根目录，通常不在这里存储文件

- boot      启动目录
- bin     系统二进制目录，存放普通用户级的GNU命令
- sbin     系统超级二进制目目录,存放管理理员级别的 GNU 命令
- usr      资源目录 (User System Resources)
  - bin  用户二进制目录,存放用户级的 GNU 命令
  - sbin 用户超级二进制目录,存放管理理员用户的 GNU 命令
  - local   当地二进制目录
    - bin
    - sbin
- opt  --》option  选装   第三方开发的程序
- dev   设备目录
  - null   无底洞（丢弃）
  - zero  无限0数据流  （产生特定的空白文档  填充）
  - shm  内存文件夹
  - random 随机数发生器（不给限定时  慎用）
  - urandom 非阻塞的随机数发生器
- etc  系统配置文件目录 (et cetera)
- proc  当前的进程、运行状态信息的目录
- root  管理员家目录
- home  用户的家目录
- media  媒体目录,可移动媒体设备的常用挂载点,一般是系统自动挂载到这里
- mnt   挂载目录,可移动媒体设备的常用挂载点,一般是留给用户手动挂载
- lib  系统库目录，存放系统和应用程序的库文件
- srv  服务目录，存放本地服务的相关文件
- sys  系统目录  存放系统硬件信息的相关文件
- run 运行目录,存放系统运作时的运行时数据
- tmp 临时目录,可以在该目录中创建和删除临时工作文件
- var 可变目录,用以存放经常变化的文件,比如日志文件

## 目录操作

- 绝对路径: /usr/local/bin
- 相对路径: ../foo/bar
- 命令列表
  - pwd     显示当前目录的绝对路径
  - ls      显示当前目录文件
  - ls  -l     以列表形式显示文件
  - ls  -lh  友好方式显示列表 (k   MB  数据有单位)
  - 隐藏一个文件  在文件名/文件夹名前前加一个点    .a   
  - ls -a/A   显示隐藏文件  all
  - cd   xxx   切换文件目录
  - cd  -   回到上一次所在位置  切换
  - mkdir  abc  创建名为abc的目录
  - mkdir -p a/b/c  创建三层目录结构  a/b/c
  - touch + 文件名  创建文件  可以增加一个文件
  - alias    自定义别名
  - history  可查看历史命令
    - bashrc  配置显示时间:export  HISTTIMEFORMAT="[%y-%m-%d_%T]"
    - 修改 bashrc 后使其生效: source ~/.bashrc 或 . .bashrc

练习:mkdir -p  a/{b/{d/{x,y,z},e},c/{f/{o,p,g},g}}

​         tree a

或  

1. mkdir -p a/{b/{d,e},c/{f,g}}
2. touch a/b/d/{x,y,z}
3. tree  a

a
├── b
│   ├── d
│   │   ├── x
│   │   ├── y
│   │   └── z
│   └── e
└── c
    ├── f
    │   ├── g
    │   ├── o
    │   └── p
    └── g

ls  -lR  a/    分开查看

## 文件操作

#### 命令列表

- cp   aa  ../bb/   将aa文件复制到../bb目录
- mv   aa  .../bb  讲aa文件 移动到../并改名为bb
- rm   foo            删除foo文件
- rm  -r   foo        删除foo文件夹
- touch    abc      在当前文件夹创建一个abc文件,如果已存在则忽略
- ln   -s   abc  def   在abc文件创建一个软连接

#### cp / mv/ rm  通用参数

-   -i    询问是否覆盖
-  -n   若目录文件已存在  则停止操作
-  -f    若  目录文件已存在,则强制操作,覆盖前不提示
-  -r    递归对文件夹执行某操作(mv  不需要 -r)

#### ln 命令

- 软链接 :ln  -s  foo  bar  
  - 可以跨越分区创建
  - 内部只记录 目标文件的路径,类似 创建快捷方式
  - 通过软链接修改文件,源文件会发生修改
- 硬链接  :ln  foo  bar
  - 只能在同分区内创建
  - 一个文件的多个硬链接相当于一个文件有多个名字,只占用一个文件大小
  - 修改硬链接时,所有同源的硬链接都会发生变化 (相当于一个人换了个住址)

#### 压缩文件处理

- tar
  - 压缩:tar  -czf  abc.tar.gz  abc/
  - 解压:tar  -xzf   abc.tar.gz
- zip
  - 压缩:zip -r  abc.zip  abc/
  - 解压: unzip  abc.zip

#### 查找文件   find

- 查找当前文件夹下全部文件:find  ./
- 只查找文件     :  find  ./  -type   f
- 只查找目录     :   find  ./  -type  d
- 只查找链接     :   find   ./  -type  l
- 按名称查找     :   find   ./  -name  '*.py'
- 按权限查找     :   find   ./  -perm  0644
- 按大小查找     :   find   ./  -size  +1k  -size -5k   (1-5k间的文件) 

## 进程管理

- ps  : proces  status
- ps -aux 或 ps  ex  查看进程
- top  -p  PID1,PID2,PID3,...,PID20    动态监控进程
- free  -m  以Mb 为单位查看内存
- kill
  - 给进程发送信号,信号详情:man  signal
  - -1  (HUP)  不间断重启
  - -9   (KILL)  强制杀死进程
  - -15  (TERM) 正常终止进程(default)
- pkill  [ProcessName]    按名字处理进程

- killall  [MatchedProcessName]   处理名字匹配的进程
- uptime   查看系统状态

## 权限管理

- sudo   以管理员身份执行其他程序    (提升权限)
- su  -   切换用户身份
- user和group
  - groupadd  admin
  - useradd -G adm,sudo -m -s /bin/bash bigcat
- chmod   修改权限
  -  三组二进制位   rwx
  - chmod   -R  a+x,u+ rw, g+r,o-w  path
- chown -R `id -u`:`id -g` filename 修改文件所有者和组

## 日志管理

- cat  查看文件
- echo xyz : 打印文文本
- echo xyz > a.txt : 将输出的文本重定向到文件a.txt中,a.txt原有内容会被覆盖
- echo xyz >> a.txt : 将输出的文本追加到文件a.txt中,a.txt原有内容不会被覆盖
  cat 文文件名 : 查看文文件
- head  -n  N   前N行
- tall  -n  N    后N行
- less 
  - 按  j  向下
  - 按  k  向上
  - 按  f  向下翻屏
  - 按  b 向上翻屏
  - 按  g  到全文开头
  - 按 G 到全文结尾
  - 按  q  退出
- sort   排序
- uniq 去重,依次排列,常跟在sort  后面使用
- awk  '{print $N}'  打印出相关列
- wc   字符(-c)  单词(-w)   行(-l)的计数
- history | awk '{print $2}'| sort | uniq -c| sort -n -r | head -10
- sort  -n  -r   前面序号反向排序
- watch -n 1.5 [command] 动态查看执行结果

## 查找

- grep

  参数

  - -i   忽略大小写
  - -I   忽略二进制文件
  -  -r  递归查找目录
  - -n   打印行号
  - -c   只显示匹配到的个数
  - -l   只显示匹配到的文件列表
  - -o  只显示匹配到的单词
  - -v  忽略制定的字段
  - -E  通过正则表达式匹配
  - vinclude = '*.py'  仅包含py文件
  - exclude='*.js'    仅包含js文件

- find  DIR  -name  '*.xxx'  找到目录下所有名字匹配的文件

  - 找出文件夹  /tmp/xyz/ 下所有的权限为 642, 大小在 10k 到 100k 之间的 log 文件
  - find /tmp/xyz/ -perm 0642 -size +10k -size -100k -name '*.log'

- which  精确查找当前可执行的命令

- whereis  查找所有匹配的命令

## 网络管理

- ifconfig   查看网卡状态

- netstat  -natp   查看网络连接状态

- ping  -i  0.5

- lsof  -i  :[POBT]   查看占用端口的程序

  - lsof   -i  tcp  查看所有TCP链接
  - lsof  -u  abc   查看用户abc 打开的所有文件
  - lsof   -p  123  查看pid 为123的进程打开的所有文件

- ~~~
     telnet  [HOST]  [PORT] 查看远程主机网络连接状况
     ~~~
   ~~~

  traceroute   [HOST]  路由追踪

- dig  [DOMAIN]    DNS查询 
DNS  域名解析

## 下载

- curl  执行  HTTP访问,也可以用来下载
- wget   下载
- apt  install
- sudo  apt  install 

## 远程登录

- ssh [username@host]   默认端口22,其他端口使用  -p参数
  - RSA  key
  - ssh-keygen  创建自己的密钥对
  - 配置修改 :  /etc/ssh/ssh_config
  - 本地执行远程命令 : ssh username@host '[command]'
  - 科学上网 :  ssh -qTfnN -D 7070 [username@host]
- SSH服务端 : sshd
  - 配置修改:/etc/ssh/sshd_config
  - 重启服务: service ssh restart
- scp -P [PORT] filename username@host:/path/
- rsync -cvrP --exclude={.git,.venv} --delete

## 登录状态

- uname  -a
- hostname   查看/修改主机名
- w   查看登录者信息
- who   查看登录者信息
- whoami   当前用户名
- last  最近登录记录

## 磁盘管理

- du  -hs   查看文件或文件夹大小
- df   -h     查看磁盘分区的占用情况
- fdisk   -l   查看分区信息
- dd   以块的级别进行磁盘复制
  - if (input  file)  输入文件
  - of(output  file)  输出文件
  - ba  (block  size)  块大小  (单位;k,m,g)
  - count   块数量
  - dd if=[src_file] of=[dst_file] bs=[size] count=[num]
  - 从 iso 文件制作启动 U 盘: dd if=/your_path/ubuntu.iso of=/dev/disk3 bs=1m

## 安装

- apt    debain 系Linux 的程序安装
  - deb 安装包
  - 修改apt源
  - apt  update    更新软件信息
  - apt  upgrade   升级相关软件包
  - apt   search  xxx  查找相关软件包
  - apt  install   xxx   安装软件包
  - apt  remove  xxx   删除软件
- yum     redhat系 Linux的程序安装
  - rpm  安装包
  - yum  install xxx
- make  编译
  - ./configure   配置编译参数
  - make   执行编译
  - make  install   安装编译文件到系统目录
  - make  clean   删除编译结果

## 文本处理工具

- emacs    神的编辑器
   ~~~
    sed -i 's/Python/Ruby/g' PythonZen.txt # 替换并将修改写入原文件
    sed '3,5s/^/# /g' PythonZen.txt # 注释掉第2到5行
    sed 's/b/____/2g' PythonZen.txt # 替换每行第二个 `b`
    sed '3,5s/^/# /g; s/b/____/2g' PythonZen.txt # 组合操作
    ~~~

  - i 插入

  ~~~
  sed '5i ====' PythonZen.txt # 在第 5 行前面插入一行
  sed '/better/i ---> A new line' PythonZen.txt # 在匹配到 `better` 的行前面插入一行
  ~~~

  - 追加

  ~~~
  sed '5a ====' PythonZen.txt # 在第5行前面插入一行
  sed '/better/a ---> A new line' PythonZen.txt # 在匹配到 `better` 的行后面追加一行
  ~~~

  - c行 替换

    ~~~
    sed '5c ---> A new line' PythonZen.txt # 替换第 5 行
    sed '/better/c ---> A new line' PythonZen.txt # 把匹配到 `better` 的行替换成新行
    ~~~

  - d 删除

  ~~~
  sed '3,5d' PythonZen.txt # 删除第 3~5 行
  sed '/better/d' PythonZen.txt # 删除包含 `better` 的行
  ~~~

- awk

  - 查找进程 ID: ps ex | grep -i chrome | awk '{print $1}'
  - 过滤网网络信息: netstat -nat | awk 'NR==1 || $6 ~ /(SYN|FIN|WAIT)/ {print $0}'

## 环境变量

- export 设置一一个全局环境变量量
- unset 删除变量量
- $PATH 可执行行行文文件的存放目目录
- export PATH=[your path]:$PATH
- $HOME 家目目录
- $PWD 当前目目录

## 基础的bash脚本语句

- #!/bin/bash 指明解释器器
- for...do...done

~~~
for v in ls ./;
do
    echo $v
done
~~~

- if...then...else...fi

~~~
if [[ -d src ]];then
    echo "Yes"
else
    echo "No"
fi
~~~

- echo
- printf
- seq 相当于 Python 下的 range
  - seq 1 5

~~~
for i in seq 1 4;
do
   echo app-$i
done
~~~

## 手册

man  [command]       操作手册

## 其他工具

- git

  - git init 初始化 .git 文文件夹
  - git add 添加追踪
  - git reset 取消 add 状态
  - git commit 提交
  - git status 查看当前状态
  - git checkout 切换分支支
  - git branch 分支支管理理
  - git pull 拉去远程代码
  - git push 将本地代码推送到远程库
  - git diff 差异对比比
  - git log 查看提交历史
  - ~/.gitconfig
  - 初始化新库

  ~~~
  $ cd your_project_dir
  $ git init
  $ git add ./
  $ git commit -m 'this is my first commit'
  $ git remote add origin git@github.com:your_github_path.git
  $ git push -u origin master
  ~~~

## python

- pip
- virtualenv
- pyenv

## 几个符号

- | 管道符: 把前面面的输出结果作为后面面命令的参数
- >重定向: 把前面面的输出结果重定向到指定的文文件中
- <重定向: 把前面面的输出结果重定向到指定的文文件中

## 简单的部署

运行一个django程序, 有数据库, nginx转发