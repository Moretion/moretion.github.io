# 宇树遥操Demo部署

## miniconda3安装

避免各种版本冲突问题，建议用conda。参照下面脚本安装：

```shell
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

refresh terminal：
source ~/miniconda3/bin/activate

 initialize conda on all available shells：
conda init --all
```

 

## 解决依赖

需要的依赖有：mujoco 、meshcat、pinocchio

注意：系统用22版Ubuntu，不容易出现版本冲突，数据处理帧率近20fps，24版只有10fps。如出现冲突，看numpy是不是2.0以下。

加速安装可以使用清华源：

```shell
pip qinghua source: -i https://pypi.tuna.tsinghua.edu.cn/simple
```

具体步骤：

```shell
conda create -n mt python=3.10 pinocchio=3.1.0 numpy=1.26.4 -c conda-forge
conda activate mt

//解决依赖
pip install mujoco 
pip install meshcat
conda install pinocchio -c conda-forge 
```

 

## 启动应用

```shell
conda activate mt
cd Desktop/motionCapture_teleoperate/
python moxun_robot.py
```



## 注意事项

1. 宇树机器人使用DDS

2. 局域网网段需设置为：192.168.123.X    

3. 使用unitree仿真环境验证后真机基本一致

4. ！惯性设备校准时，物理机器人要停机

5. 使用Linux笔记，不建议使用虚拟机

6. 官方提供AR要操作开源范例

7. 注意安装unitree\_sdk2\_python



## 源代码

联系市场同事。
