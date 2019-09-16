pip 安装python包

apt 系统包

## MVC

m：model 模型 (数据模型)

v：view   视图

c ：controller  控制

## 虚拟环境

导出虚拟环境的软件包

pip  freeze > requirement.txt

其他人重新搭建

## Git历史

Github  代码托管网站

- 配置：

git config  --global user.name xxxx

git config  --global user.email   xxxx 

- 增加 .gitignore,忽略不需要追踪的文件
  - touch .gitignore     创建一个隐藏文件
  - vim  .gitignore   将不需要追踪的文件写入  env/     /代表他是一个文件
- git  init  对仓库进行初始化  产生了一个  .git 的目录，这个文件夹就是本地仓库
  - git status  查看当前状态
- git add  ./  将当前文件夹下的所有文件添加到“暂缓区”
  - 将不需要的文件写入 .gitignore中
  - git  reset  xxx  将“暂缓区” 中的文件取消暂缓状态   代码的强制回滚
  - git diff  .gitignore  对比修改前后
- git  commit  -m   ’完成管理系统‘               将“暂存区“中的代码提交到本地仓库
- git remote add origin git@github.com:o123-code/oyg1.git
- git  push   -u  origin master   讲本地仓库推送到远程仓库  （第一次之后后面直接git push 就行了）
- ssh-keygen   在~/.ssh  目录下生成一对公钥和密钥
- 公钥内容复制到Github
- git  pull  将远程仓库的**更新**拉取到本地仓库（根据提交记录git log进行更新 ）
- git clone   把别人的库拿过来



### 解决冲突

- git  push        发现与别人修改的代码冲突
- git  pull        将线上代码拉去=取到本地
- git  status      找到冲突文件都有哪些,冲突文件的状态是:both  modified

逐一打开冲突文件,逐行解决冲突

冲突代码解决后,将代码中冲突的标记删除

- git  add  ./
- git  commit  -m  '解决冲突  ,进行了一次合并'
- git  push



### 分支操作

git branch  分支名               创建分支

git branch -l

git checkout  分支                切换分支

-------------------------------------------

git checkout -b  分支名           切换并创建











git push  -u origin 分支名 

-u  =  set  up