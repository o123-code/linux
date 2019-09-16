 leetcode-cn.com




## 常见局域网

10.0.0.0~10.255.255.255（A类） 

172.16.0.0~172.31.255.255（B类） 

192.168.0.0~192.168.255.255（C类）

## web 服务器

HTML  超文本标记语言

HTTP  超文本传输协议

​            构建在长连接基础上的短连接协议

HTTPS  是HTTP的安全版

TCP    建立连接: 三次握手

​           断开连接:四次挥手

​            可靠

​            长连接协议  (持续连接)

UDP    短连接



状态码:

200  正常

404  页面找不到

500  服务器错误



建立http服务器

~~~
#!/usr/bin/env python

import socket
import time

addr = ('127.0.0.1', 8000)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # 创建 socket对象
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # 为 sock 打开地址可重用选项
sock.bind(addr)   # 绑定服务器地址
sock.listen(100)  # 设置监听队列

# 定义 "响应报文"
html = b'''
HTTP/1.1 200 OK

<html>
    <head>
        <title>home</title>
    </head>
    <body>
        Hello world
    </body>
</html>
'''

while True:
    print('服务器已运行，正在等待客户端连接。。。')

    # 等待接受客户端连接
    # 第一个返回值是客户端的 socket 对象
    # 第二个返回值是客户端的地址
    cli_sock, cli_addr = sock.accept()
    print('接收到来自客户端 %s:%s 的连接' % cli_addr)

    # 接收客户端传来的数据，1024是接收缓冲区的大小
    cli_data = cli_sock.recv(1024)
    print('接收到客户端发来的 "请求报文": \n%s' % cli_data.decode('utf8'))

    cli_sock.sendall(html)  # 向客户端发送数据

    # 断开与客户端的连接
    cli_sock.close()
    print('连接断开, 退出！')

~~~

附加功能

~~~
#!/usr/bin/env python

import socket
import time

addr = ('127.0.0.1', 8000)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # 创建 socket对象
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # 为 sock 打开地址可重用选项
sock.bind(addr)   # 绑定服务器地址
sock.listen(100)  # 设置监听队列

# 定义 "响应报文"
template = '''
HTTP/1.1 200 OK   #协议格式 200表正常
                  #一定要有空格
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <title>Seamile</title>

        <style>
            h1, p {
                text-align: center;
                font-size: 2.5em;
            }
            .avatar {
                border-radius: 20px;
                box-shadow: 5px 5px 20px grey;
                width: 500px;
                margin: 0 auto;
                display: block;
            }
        </style>
    </head>
    <body>
        <h1>Seamile</h1>
        <div><img class="avatar" src="https://inews.gtimg.com/newsapp_ls/0/10229330043_294195/0" /></div>
        <p>%s</p>
    </body>
</html>
'''


def get_url(request_str):
    '''从 "请求报文" 中获取请求的 URL'''
    first_line = request_str.split('\n')[0]  # 取出第一行
    url = first_line.split(' ')[1]  # 按空格切分，取出中间的 URL
    return url


while True:
    print('服务器已运行，正在等待客户端连接。。。')

    # 等待接受客户端连接
    # 第一个返回值是客户端的 socket 对象
    # 第二个返回值是客户端的地址
    cli_sock, cli_addr = sock.accept()
    print('接收到来自客户端 %s:%s 的连接' % cli_addr)

    # 接收客户端传来的数据，1024是接收缓冲区的大小
    cli_request = cli_sock.recv(1024).decode('utf8')
    print('接收到客户端发来的 "请求报文": \n%s' % cli_request)

    # 获取用户的 URL
    url = get_url(cli_request)

    # 根据 URL 生成不同的返回值
    if url == '/foo':
        response = template % '爱妃退下，朕在调戏代码'
    elif url == '/bar':
        response = template % '姜伟老师没醉过，但求一醉'
    else:
        response = template % 'hello world'

    print(url, response)
    cli_sock.sendall(response.encode('utf8'))  # 向客户端发送数据

    # 断开与客户端的连接
    cli_sock.close()
    print('连接断开, 退出！')
~~~

动态页面

- 前端动态
- 后端动态

### web服务器原理

### web框架

|WebFramework   |                                                       Description|
|--------------------------------|------------------------------------------------------------------------------------------------|
|Django| 全能型框架, 大而全, 插件丰富, 文档丰富, 社区活跃, 适合快速开发, 内部耦合比较紧(各部分模块联系紧) |
|Flask|微型框架, 适合新手学习, 极其灵活, 便于二次开发和扩展, 生态环境好, 插件丰富|
|Tornado| 异步处理, 事件驱动 (epoll), 性能优异|
|Bottle |单文件框架, 结构紧凑,适合初学者阅读源码,了解 Web 原理|
|web.py |代码优美, 适合学习源码|
|Falcon |性能优异适合写 API 接口|
|Quixote |著名的豆瓣网的使用|
|Sanic |性能秒杀以上所有,但不是很稳定。|

## Tornado

### 安装

~~~
pip install tornado
~~~

### 简单实现

~~~
  1 #!/usr/bin/env python    #如果不加   后面运行时要写  python ./demo1.sh
  2 import tornado.ioloop
  3 import tornado.web
  4 
  5 class MainHandler(tornado.web.RequestHandler):
  6     def get(self):
  7         self.write("Hello, world")
  8 def make_app():
  9     return tornado.web.Application([
 10         (r"/", MainHandler),
 11     ])
 12 if __name__ == "__main__":  #把整个文件作为一个整体去执行的时候,下面的代码才会去执行;但把整个文件当做一个模块导入到别的文件中 下面的代码不会去执行;__name__是一个全局变量
 13     app = make_app()
 14     app.listen(8888,'127.0.0.1')
 15     loop = tornado.ioloop.IOLoop.current()                                    
 16     loop.start()  #把协程驱动
~                                   
~~~

### 启动参数

~~~
  1 #!/usr/bin/env python
  2 import tornado.ioloop
  3 import tornado.web
  4 from tornado.options import parse_command_line, define, options
  5 define("host", default='0.0.0.0', help="主机地址", type=str)
  6 define("port", default=8888, help="主机端口口", type=int)                     
  7 
  8 class MainHandler(tornado.web.RequestHandler):
  9     def get(self):
 10         self.write("Hello, world")
 11         
 12 
 13 def make_app():
 14     return tornado.web.Application([
 15         (r"/", MainHandler),
 16     ])
 17 if __name__ == "__main__":
 18     parse_command_line()
 19     
 20     app = make_app()
 21     print('server running on %s:%s' % (options.host,options.port))
 22     app.listen(options.port, options.host)
 23     
 24     loop = tornado.ioloop.IOLoop.current()
 25     loop.start()  #把协程驱动
~                                   
~~~

### 路由处理

~~~
  1 #!/usr/bin/env python
  2 import tornado.ioloop
  3 import tornado.web
  4 from tornado.options import parse_command_line, define, options
  5 define("host", default='0.0.0.0', help="主机地址", type=str)
  6 define("port", default=8888, help="主机端口口", type=int)
  7 
  8 class WuzetianHandler(tornado.web.RequestHandler):
  9     def get(self):
 10         self.write("普天之下,莫非王土")
 11 class KaiHandler(tornado.web.RequestHandler):
 12     def get(self):
 13         self.write("无限接近死亡,才能体会到生命的真谛")
 14 class LibaiHandler(tornado.web.RequestHandler):
 15     def get(self):
 16         self.write("一剑轻抬十四周")
 17 
 18 
 19 def make_app():
 20     return tornado.web.Application([
 21         (r"/", WuzetianHandler),
 22         (r"/foo", KaiHandler),
 23         (r"/bar", LibaiHandler),                                              
 24     ])
 25 if __name__ == "__main__":
 26     parse_command_line()
        app = make_app()
 36     print('server running on %s:%s' % (options.host,options.port))
 37     app.listen(options.port, options.host)
 38 
 39     loop = tornado.ioloop.IOLoop.current()
 40     loop.start()  #把协程驱动                                                
                                     
~~~

####  URL

资源的定位

http://11.22.33.44:80/foo/bar/xxx.html?aaa=123&bbb=456#top                       |                        |

| http://  | root:password@               | 11.22.33.44 | :80    | /foo/bar/xxx.html | ?aaa=123&bbb=456 | #top |
| -------- | ---------------------------- | ----------- | ------ | ----------------- | ---------------- | ---- |
| 协议协议 | 用户名 密码(不安全 一般不用) | 主机名      | 端口号 | 路径              | 参数             | 锚点 |

通信协议:http  https   ftp  socks   redis   mysql



### 处理 get 和 post 请求

~~~
  1 #!/usr/bin/env python                                                         
  2 import tornado.ioloop
  3 import tornado.web
  4 from tornado.options import parse_command_line, define, options
  5 define("host", default='0.0.0.0', help="主机地址", type=str)
  6 define("port", default=8888, help="主机端口口", type=int)
  7 
  8 class WuzetianHandler(tornado.web.RequestHandler):
  9     def get(self):
 10         name = self.get_argument('name')
 11         self.write("hello, %s" % name)
 12 class KaiHandler(tornado.web.RequestHandler):
 13     def get(self):
 14         self.write("无限接近死亡,才能体会到生命的真谛")
 15 class LibaiHandler(tornado.web.RequestHandler):
 16     def get(self):
 17         self.write("一剑轻抬十四周")
 18 
 19 class TestHandler(tornado.web.RequestHandler):
 20     def get(self):
 21         name = self.get_argument('name')
 22         self.write("%s一剑轻抬十四周" % name)
 23 
 24 
 25 def make_app():
 26     return tornado.web.Application([
 27         (r"/", WuzetianHandler),
            (r"/bar", LibaiHandler),
 29         (r"/foo", KaiHandler),
 30         (r"/test", TestHandler),
 31     ])
 32 if __name__ == "__main__":
 33     parse_command_line()
 34 
 35     app = make_app()
 36     print('server running on %s:%s' % (options.host,options.port))
 37     app.listen(options.port, options.host)
 38 
 39     loop = tornado.ioloop.IOLoop.current()
 40     loop.start()  #把协程驱动                                                
                                                               40,1         底端
                                                           1,1          顶端

~~~



HTTP的请求方法

|Method    | Description|
|---------------|-----------------------------------------------|
|post |对服务器内容进行创建或者修改|
|get |从服务器中获取一些内容 一般不对数据进行修改|
|put |强调对服务器进行修改|
|delete| 请求服务器删除指定的⻚面。 |
|head |类似于 GET 请求,只用来获取请求头,一般用在网路测试时使用|
|patch |是对 PUT 方法的补充,用来对已知资源进行局部更新 。|
|options | 列举服务器支持的请求方法|
