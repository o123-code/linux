## ROM

### 概述

- 对象关系映射
- 面向对象编程把所有实体看成对象,关系型数据库则是采用实体之间的关系(relation)连接数据。关系也可以用对象表达,就能使用面向对象编程,来操作关系型数据库

### 作用

在编程中把面向对象的概念跟数据库中表的概念对应起来

### 优点

- 数据模型都在一个地方定义,更容易更新和维护,也利于重用代码。
- ORM 有现成的工具,很多功能可以自动完成,比如数据预处理、事务等。
- 它迫使你使用 MVC 架构,ORM 就是天然的 Model,最终使代码更清晰。
- 基于 ORM 的业务代码比较简单,代码量少,语义性好,容易理解。
- 不必编写性能不佳的 SQL。这点也是其缺点 ,因为也不能编写性能极佳的SQL

### 常用的ORM

在python下

- Django-ORM
- SQLAlchemy
- Peewee 等

### 示例

~~~
import datetime

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column, String, Integer, Float, Date
from sqlalchemy.ext.declarative import declarative_base

# 建立连接与数据库的连接
engine = create_engine('mysql+pymysql://oyg:151782@localhost:3306/tornado')

Base = declarative_base(bind=engine)  # 创建模型的基础类
Session = sessionmaker(bind=engine)   # 创建会话类


class User(Base):
    '''类本身对应数据库里的表结构'''
    __tablename__ = 'user'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(20), unique=True)
    birthday = Column(Date, default=datetime.date(1990, 1, 1))
    city = Column(String(10), default='上海')


Base.metadata.create_all()  # 创建表结构


# 定义的每一个对象，对应数据库里的一行数据
bob = User(name='bob', birthday=datetime.date(1990, 3, 21), city='上海')
tom = User(name='tom', birthday=datetime.date(1995, 9, 12))
lucy = User(name='lucy', birthday=datetime.date(1998, 5, 14), city='北京')
jam = User(name='jam', birthday=datetime.date(1994, 3, 9), city='深圳')
alex = User(name='alex', birthday=datetime.date(1992, 3, 17), city='北京')
eva = User(name='eva', birthday=datetime.date(1987, 7, 28), city='深圳')
rob = User(name='rob', birthday=datetime.date(1974, 2, 5), city='上海')
ella = User(name='ella', birthday=datetime.date(1999, 5, 26), city='北京')



# 定义与数据库的会话
session = Session()
#添加数据
session.add_all([bob,tom,lucy,jam,alex,eva,rob,ella])

# session.add(bob)
# session.add(tom)
# session.add(lucy)
# session.add(jam)
# session.add(alex)
# session.add(eva)
# session.add(rob)
# session.add(ella)

session.commit()
# 懒加载 惰性加载 -> 惰性求值

#删除数据
In [15]: test = User(name='test', birthday=datetime.date(1999, 5, 26), city='北京')      In [16]: session.add(test)                                                       
In [17]: session.commit()                                                        
In [18]: session.delete(test)                                                    
In [19]: session.commit()  

#修改数据
bob.city = '安徽'
session.commit()

#查询数据
u_query = session.query(User)
# 先定义表的查询对象
# 直接获取主键(ID)为 5 的数据
user = u_query.get(5)
print(user.id, user.name)
# 使用 filter_by 按条件查询  不能进行id>  <  等查询
user = u_query.filter_by(id=7).one()    
print(user.id, user.name, user.birthday)
# 使用 filter 进行范围查询,并对结果进行排序
users = u_query.filter(User.id>2).order_by('birthday')
for u in users:
print(u.name, u.birthday, u.money)
# 根据查询结果进行更新
users = u_query.filter(User.id>2)
users.update({'money': User.money - 1}, synchronize_session=False)
sessiom.commit()
# 按数量取出数据: limit / offset
users = u_query.limit(3).offset(4)
for u in users:
print(u.id, u.name)
# 计数
num = u_query.filter(User.money>200).count()
print(num)
# 检查是否存在
exists = q.filter_by(name='Seamile').exists()
result = session.query(exists).scalar()
print(result)

~~~

