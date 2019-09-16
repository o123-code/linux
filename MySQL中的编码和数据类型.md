## 字符集

### 使用场合

- 保存数据的时候
- 数据传输的时候
- 在存续的时候
  - 在MySQL的服务器器上, 在数据库中, 在表的使用上, 在字段的设置上.
  - 在服务器安装的时候, 可以指定默认的字符集

### 常见字符集

- UTF8: 国际通用编码, 一个汉字最多占用3个字节
- UTF8MB4: 一个汉字最多占用4个字节
- GB2312: 简体中文字符, 一个汉字最多占用2个字节
- GB: 所有的中文字符
- ASCII: 基于罗⻢字母表的一套字符集, 采用1个字节的低7位表示字符, 高位始终为0。
- LATIN1:对ascll做了扩展,一个字节表示字符, 启用了高位, 扩展了字符集的表示范围

### 查看当前字符集

~~~
mysql> show variables like 'character_%';
~~~

### 修改当前MySQL系统字符集

- 全部修改

~~~
set  names  gbk;
~~~

- 指定修改

~~~
set character_set_client = gbk;
~~~

- 修改是临时的 ,mysql 链接断开后  ,会恢复原状

## 校对集

### 概念

在某一种字符集下, 为了使字符之间可以互相比较, 让字符和字符形成一种关系的集合

### 命名约定

以其相关的字符集名开始, 通常包括一个语言名, 以_ci 、 _cs 或 _bin 结束。
_ci : 大小写不敏感
_cs : 大小写敏感
_bin : binary collation 二元法, 直接比较字符的编码, 可以认为是区分大小写的, 因为字符集中'A'和'a'的编码不同。

~~~
show character set; -- 查看字符集 和 校对集
show collation; -- 显示所有的校对集
~~~



## 数据类型

### 整形

tinyint    smallint   mediumint   int/integer       bigint

![1567590878963](/tmp/1567590878963.png)

- 一个无符号数必是非负数
- 显示宽度(zerofill)   整形显示宽度  ,位数不足时用0补充

### 浮点型

![1567590833310](/tmp/1567590833310.png)

定点数的位数更加长

使用方式:

- float(M,D)
- double(MD)
- decimal(M,D)
- M是总支持长度,D是小数点后的位数

### 字符串类型

![1567590731674](/tmp/1567590731674.png)

 与 VARCHAR 类型的区别

![1567590772587](/tmp/1567590772587.png)

### 时间类型

![1567590434610](/tmp/1567590434610.png)

- datetime

~~~
insert into datetime_test values('2019-4-2 16:54:00');
insert into datetime_test values('2019/4/2 16:54:00');
insert into datetime_test values(now());
-- 年年份最大大支支持4个⻓长度
insert into datetime_test values('10000/4/2 16:54:00');
insert into datetime_test values('9999/4/2 16:54:00');
~~~

- time

~~~
insert into time_test values('12:12:12');
insert into time_test values('100:12:12');
insert into time_test values('-100:12:12');
insert into time_test values('10 10:12:12');
-- 时间的范围是: [-838:59:59 - 838:59:59]
insert into time_test values('839:12:12'); -- 错误的
~~~

- timestamp 时间戳类型
  - 时间戳类型在显示方面和datetime是一样的, 在存储上不一样
  - 范围从 1970-1-1 0:0:0 到 2038-1-19 11:14:07
  - 时间戳使用用 4 个字节表示
  - 该值大小与存储的位长有关: 2 ** (4 * 8 - 1)
- year

~~~
-- 从1900年年开始 - 1900+255
insert into `year` values(now());
insert into `year` values('2155'); -- 年年份最大大值
insert into `year` values('2156'); -- 错误
~~~

### 枚举

- 多选一时使用
- 前端单选框时使用
- 优点
  - 限制了了可选值
  - 节省空间
  - 运行效率高

### 集合(set)

里面最多有64个成员 

~~~
create table t7 (
name varchar(32),
hobby set('吃','睡','玩','喝喝','抽')
);
insert into t7 values('张三','睡,抽,玩,吃,喝喝');
insert into t7 values('李李四','睡,抽');
~~~

### 布尔值

- 与python类似　底层是ｉｎｔ
- bool  (1,0)

~~~
create table `bool`(
cond boolean
);
insert into `bool` set cond=True; -- 成功
insert into `bool` set cond=False; -- 成功
insert into `bool` set cond=1; -- 成功
insert into `bool` set cond=-1; -- 成功
insert into `bool` set cond=0; -- 成功
insert into `bool` set cond=0.1; -- 成功
insert into `bool` set cond='True'; -- 失败
~~~

### 列的属性

- 插入的值是否

  - `null`     可以为空　（默认不写）
  - `not null`: 不可以为空　插入空值会报错

- default  默认值

  - 一般与null搭配

  ~~~
  create table default_test (
  id int primary key auto_increment,
  username varchar(32) default 'admin' not null,
  pwd varchar(16) default 123456
  );
  insert into
  default_test (username) values ('admin');
  ~~~

- auto_increment

  - 自动增长的列　　（常用在ｉｄ）
  - 默认从１开始
  - 与主键配合使用

- primary  key

  - 主键一般是唯一的标识
  - 不能为空，不能重复，唯一的

  ~~~
  create table auto_inc (
  id int primary key auto_increment,
  name varchar(32));
  ~~~

- unique

  - 唯一键　　去重
  - 邮箱，手机号，名字，等
  - 直接在后面加unique

- comment

  - 字段说明：对相应字段进行说明
  - 打印时不会被解析　　cmatrix  lolcat

  ~~~
  create table test_cmt (
  ctime datetime comment '这个字段代表创建日日期'
  );
  ~~~

## mysql  运算符

### 算数运算符

~~~
select 123 + 543, 321 * 5, -456 / 2, 10 % 3, 2 / 0, 3 % 0;
/*
输出:
+-----------+---------+-----------+--------+-------+-------+
| 123 + 543 | 321 * 5 | -456 / 2| 10 % 3 | 2 / 0 | 3 % 0 |
+-----------+---------+-----------+--------+-------+-------+
|666        |1605     | -228.0000 |1     |NULL   |NULL |
+-----------+---------+-----------+--------+-------+-------+
1 row in set, 2 warnings (0.00 sec)
*/
~~~

### 比较运算符

![1567590970694](/tmp/1567590970694.png)

- 常规比较

~~~
select 1=2, 2<3, 3<=4, 4>5, 5>=3, 8!=9, 8<>9, 'abc' = 'Abc', 'z' > 'a';

       |0    |1    |1   |0   |1    |1    |1         |1            |1
~~~

- 范围比较

~~~
123 between 100 and 200  ===>1
'b' in ('a', 'b', 'c')   ===>1
~~~



- null比较

  ~~~
  12 is null  ==> 0
  23 = null   ==> null
  null = null ==> null
  null <=> null ==> 1
  null is null  ==> 1
  ~~~

  

- 模糊比较：like

  ~~~
  'HelloWorld' like 'hello%'    ===>1
  ~~~

  

  ### 逻辑运算符

  ![1567591000988](/tmp/1567591000988.png)



MySQL中%是通配符  *不是通配符