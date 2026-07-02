**unity插件使用教程**

**一.unity软件使用**

**1.打开Unity Hub软件(若未下载可官网下载：**<https://unity.cn/releases>**)**
![](./images/media/image1.png)

**2.检查是否安装编辑器（**最低可用版本2019.1.0**）**
![](./images/media/image2.png)

若未下载可点击安装unit编辑器按钮，按照unity编辑器或者官网下载（地址：<https://unity.cn/releases/full/2019>）

![](./images/media/image3.png)

**3.新建项目或打开已有项目**
![](./images/media/image4.png)

新建项目
![](./images/media/image5.png)

创建项目后自动打开新建的项目
![](./images/media/image6.png)

**4.打开后如果存在警告(无警告可跳过此步骤)**
![](./images/media/image7.png)

点击window-package Manager
![](./images/media/image8.png)

点击Visual Studio Editor--Update to 2.0.22
![](./images/media/image9.png)

更新完成后关闭弹窗
![](./images/media/image10.png)

**5.导入unity插件**

unity插件2.3.0版本下载

[mostechPlugin2.3.0.unitypackage](./assets/mostechPlugin2.3.0.unitypackage)

将motionPlugin2.1.0插件文件拖拽至Project-Assets里面
![](./images/media/image11.png)

点击import按钮
![](./images/media/image12.png)

**6.驱动全身设备**

点击assets---mostech---scenes
![](./images/media/image13.png)

点击Motion Animator Scene或Motion Transforms Scene
![](./images/media/image14.png)

在Hierarchy点击MotionDriver
![](./images/media/image15.png)

点击inspector---Motion Source Manager(script)输入motion中对应的ip和端口
![](./images/media/image16.png)

连接设备后，并做好姿势校准
![](./images/media/image17.png)

点击运行，可传输实时数据
![](./images/media/image18.png)

**7.驱动手套设备运行**

点击assets---mostech---scenes
![](./images/media/image19.png)

点击Motion Hand Scene
![](./images/media/image20.png)

点击inspector---Motion Source Manager(script)输入motion中对应的ip和端口
![](./images/media/image21.png)

连接设备后，并做好姿势校准
![](./images/media/image22.png)

点击运行，可传输实时数据
![](./images/media/image23.png)

**8.驱动组合设备运行**

选择的模特与全身设备一样
![](./images/media/image24.png)

点击inspector---Motion Source Manager(script)输入motion中对应的ip和端口
![](./images/media/image25.png)

motion上将设备组合起来，并做好姿势校准
![](./images/media/image26.png)

点击运行，可传输实时数据
![](./images/media/image27.png)

**9.驱动多设备运行**

在Hierarchy选中Mostech-Robot进行粘贴复制
![](./images/media/image28.png)

点击inspector---Motion Instances输入对应的模特数
![](./images/media/image29.png)

点击motionDriver再点击inspector---Motion Instances---Element0、Element1选择相对应的Mostech-Robot
![](./images/media/image30.png)

点击Mostech-Robot再点击inspector---Actor ID输入不同的数字
![](./images/media/image31.png)

点击Mostech-Robot再点击inspector---模特位置调整，修改x,y,z
![](./images/media/image32.png)
![](./images/media/image33.png)

motion上做好姿势校准后，untiy上点击运行按钮
![](./images/media/image34.png)

**10.一套设备驱动多个模特**

在Hierarchy选中Mostech-Robot进行粘贴复制
![](./images/media/image28.png)

点击inspector---Motion Instances输入对应的模特数
![](./images/media/image29.png)

点击motionDriver再点击inspector---Motion Instances---Element0、Element1选择相对应的Mostech-Robot
![](./images/media/image30.png)

点击Mostech-Robot再点击inspector---Actor ID输入相同的数字
![](./images/media/image31.png)

点击Mostech-Robot再点击inspector---模特位置调整，修改x,y,z
![](./images/media/image32.png)
![](./images/media/image33.png)

motion上做好姿势校准后，untiy上点击运行按钮
![](./images/media/image35.png)

**二.motion studio软件数据广播使用**

**1.打开Motion Studio软件**
![](./images/media/image36.png)

2.进入主页界面，可新建项目或者打开已新建好的项目
![](./images/media/image37.png)
![](./images/media/image38.png)

**3.选中项目后，进入捕捉页面**
![](./images/media/image39.png)

**4.开启数据广播**

点击左上角功能-数据广播按钮
![](./images/media/image40.png)

开启bvh广播（端口号可随意输入）
![](./images/media/image41.png)
![](./images/media/image42.png)

**5.数据广播开启后，未连接设备可播放离线数据**

查看文件列表，双击选择数据文件播放
![](./images/media/image43.png)

播放文件
![](./images/media/image44.png)

unity IP和端口配置完成后，点击播放按钮，可播放离线数据
![](./images/media/image45.png)

**6.数据广播开启后，连接设备可播放实时数据**

接收器连接电脑，当设备列表有设备显示时，点击连接按钮进行设备连接
![](./images/media/image46.png)

连接成功后，可将绑带和设备按照提示依次穿戴在身上
![](./images/media/image47.png)

穿戴完成，点击姿势校准，根据提示进行T-Pose、A-Pose、OK-Pose(有手套设备组合时)姿势校准
![](./images/media/image48.png)
![](./images/media/image49.png)
![](./images/media/image50.png)

unity IP和端口配置完成后，点击播放按钮，可播放实时数据
![](./images/media/image51.png)
![](./images/media/image52.png)
