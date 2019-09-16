#!/bin/bash


read -p '请输入一个数字:' num

echo $num



function foo() {

    echo "参数 0 : $0"
    echo "第1个参数 $1"
    echo "第2个参数 $2"
    echo "第3个参数 $3"

    echo "全部的参数: $*"
    echo "全部的参数: $@"

    echo "一共有 $# 个参数"
}




# foo 111 222 333 444 555 666
#
#
# echo '-----------------------'
#
#
# echo "参数 0 : $0"
# echo "第一个参数 $1"
# echo "第二个参数 $2"
# echo "第三个参数 $3"
#
# echo "全部的参数: $*"
# echo "全部的参数: $@"
#
# echo "一共有 $# 个参数"









# for i in `seq 1 10`
# do
#     if [[ $[$i % 2] == 0 ]]
#     then
#         echo "这是一个偶数：$i"
#     else
#         echo "这是一个奇数：$i"
#     fi
# done

# for ((i=0; i<10; i++))
# do
#     echo "it is $i"
# done
