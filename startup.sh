#!/bin/sh
echo  配置JDK

rpm -ivh ./jdk-8u291-linux-x64.rpm

#环境变量配置，截取#表示从前向后截取，删除最少匹配。%表示从后向前匹配，删除最少匹配。两个表示删除最多匹。匹配规则为正则表达式

tmp=$(which java)

tmp1=$(ls -lrt $tmp)

#需要将tmp1的地址截取出来
tmp2=$(ls -lrt ${tmp1#[^>]*>})

#将java命令所在的绝对路径截取出来
javaPath=${tmp2#[^>]*>[[:space:]]}

#将javaHome截取出来
JAVA_HOME=${javaPath%/bin/java}

#配置环境变量
echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile
echo 'export JRE_HOME=$JAVA_HOME/jre

export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >> /etc/profile

source /etc/profile

echo =================================
echo  自动化部署脚本启动
echo =================================

echo 启动项目
java -jar docker-demo.jar &
echo 项目启动完成

