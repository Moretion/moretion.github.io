**Blender插件使用教程**

**一、blender**

未下载的可去[Blender下载和汉化 --
Blender中国社区](https://www.blendercn.org/downloadme)下载

下载完成后，按图中顺序即可切换为中文

![](./images/media/image1.png){width="7.791666666666667in"
height="5.3287839020122485in"}

![](./images/media/image2.png){width="2.5520833333333335in"
height="3.9270833333333335in"}

**二、插件下载**

[请至钉钉文档查看附件《MotionStudio_Blender_4_Win64_v0.8.26.zip》](https://alidocs.dingtalk.com/i/nodes/GZLxjv9VGGPdYEjbHOn5o9dgV6EDybno?iframeQuery=anchorId%3DX02m56dihd1wqihvsj8u)

**三、插件安装说明**

1、插件下载完成后，无需解压，先打开Blender 4.x

![](./images/media/image3.png){width="7.270833333333333in"
height="0.375in"}

2、在菜单栏中点击编辑→偏好设置，或者按下Ctrl键和
，键，打开首选项界面，如下图：

![](./images/media/image4.png){width="7.364583333333333in"
height="4.895833333333333in"}

3、偏好设置界面-点击安装按钮

![](./images/media/image5.png){width="7.791666666666667in"
height="4.4593810148731405in"}

4、选择插件下载的目录，然后选中刚才下载的插件压缩包。然后点击右下角从磁盘安装。

![](./images/media/image6.png){width="7.791666666666667in"
height="4.477487970253718in"}

4、安装成功后会自动启用，如未启用，请手动点击启用

![](./images/media/image7.png){width="7.041666666666667in"
height="5.822916666666667in"}

**四、插件使用说明**

**1、在blender中打开MS插件**

**1）在Blender世界场景的右上角的坐标轴旁边，点击向左的小箭头，可以弹出插件所在界面**

![](./images/media/image8.png){width="3.0in"
height="3.2708333333333335in"}

![](./images/media/image9.png){width="2.90625in" height="4.0in"}

**2）点击右侧MS MOCAP页签，打开本插件页面**

![](./images/media/image10.png){width="2.875in"
height="3.2708333333333335in"}

> **3）插件界面说明**

![](./images/media/image11.png){width="2.8125in" height="3.34375in"}

**如上图，插件界面从上到下分为3个区域，分别为：**

**3.1 连接设置区**

此处可以切换网络连接方式，并且设置连接地址和端口。

![](./images/media/image12.png){width="2.5416666666666665in"
height="3.2604166666666665in"}

下方从左到右依次是：连接，同步以及录制按钮。

连接：用来连接到MS服务器,需要先在MS中开启数据广播

同步：在角色列表中点击显示骨骼/模型后，可以开启同步动作，关闭后不再驱动角色的骨骼的移动和旋转

录制：录制接收到的动作

**3.2 角色设置区（需连接MS成功后才显示）**

此处可以显示接收到的角色列表，并且可以控制每个角色的显示隐藏以及角色的姿态。

![](./images/media/image13.png){width="2.625in"
height="5.239583333333333in"}

角色名称/ID：点击角色名称/角色ID按钮，可切换角色列表中角色显示的内容（角色名称或角色ID）

角色显示/隐藏：点击角色右侧的显示/隐藏按钮，可以切换角色的显示状态（标题栏的显示隐藏按钮可以设置全部角色的显示隐藏状态，每个角色也可以单独设置）

角色同步/TPose姿态：点击最右侧角色姿态按钮，可以切换全部或某个角色的姿态为TPose，或者同步当前MS的姿态

**3.3 关于插件**

此处可以查看插件的版本，打开本插件指南，以及进行插件更新和进入官网。

注：更新插件后，需要重新启动Blender或者在插件设置中重新启用本插件

**2、连接Motion Studio并驱动Blender中的角色模型**

**1）连接Motion studio**

根据MotionStudio中对应的数据广播设置的ip地址及端口号，选择TCP或者UDP连接。

**1.1 TCP连接**

使用 TCP 连接时，需要点击最左侧的 TCP 按钮(高亮为选中)。然后在 blender
地址中填入 MotionStudio 中的设置的 IP及对应端口号(默认为 9999)

![](./images/media/image14.png){width="2.4166666666666665in"
height="0.6666666666666666in"}

![](./images/media/image15.png){width="5.864583333333333in"
height="5.78125in"}

**1.2 UDP连接**

在 MotionStudio 中的数据广播设置为 UDP 连接，设置端口号。在目标 IP
处输入插件中的安装电脑对应的IP 地址，并设置端口号。

![](./images/media/image16.png){width="5.729166666666667in"
height="5.645833333333333in"}

blender中使用 UDP 连接时，除以上操作外，还需要填写和Motion
Studio中目标ip的端口号

![](./images/media/image17.png){width="2.5416666666666665in"
height="0.6979166666666666in"}

**2）blender插件中开启连接**

在第一步确认ip设置正确后，点击插件左上角**连接**按钮，即可连接MotionStudio数据广播。连接按钮为红色则表示连接成功（此时再次点击可以关闭连接）。此时，场景中将自动加载默认的角色模型，并开启动作同步。同时角色设置区中会同步更新角色列表，如下图：

![](./images/media/image18.png){width="7.791666666666667in"
height="4.542844488188976in"}

**3）切换数据源或切换连接协议**

当需要在Motion
Studio中切换数据源时（实时→录制，不同录制数据，TCP→UDP等），需要先关闭当前插件的连接，即点击连接设置区中的断开按钮。当Motion
Studio中切换好新数据源时，再次点击连接按钮，可驱动角色模型

![](./images/media/image19.png){width="2.8125in" height="0.375in"}

**3、录制动作与保存导出录制的动作**

**1）录制动作**

在完成连接MotionStudio的步骤并同步驱动角色后，可以点击连接设置区域的录制按钮

![](./images/media/image20.png){width="2.8125in"
height="0.4166666666666667in"}

当录制进行时，按钮会变为如下状态，此时再次点击可以停止录像

![](./images/media/image21.png){width="2.8125in"
height="0.3854166666666667in"}

注：录制完一个后需要将当前的文件导出，如未导出，录制第二个，会将第一个录制内容覆盖掉

**2）导出录制好的动作**

导出录制的动画时，最好先关闭同步驱动（但不要断开连接），然后点击Blender菜单栏→文件→导出，选择需要导出的文件格式，此处以FBX文件为例，点击FBX格式

![](./images/media/image22.png){width="4.354166666666667in"
height="5.604166666666667in"}

在弹出的导出选项对话框中，首先在上方路径中指定好要导出到的位置，然后在最下方输入要保存的文件名。在右侧的导出选项面板中，注意在物体类型中至少要勾选骨架和网格（按住Shift键可以多选），并且在下方要勾选动画选项。确认好选项后，点击右下角导出
FBX按钮导出录制的动作文件

![](./images/media/image23.png){width="7.458333333333333in"
height="5.424242125984252in"}

**3）回放录制的动作**

当导出完成后，点击连接设置中的断开连接按钮，可以清除场景中的全部角色模型。

![](./images/media/image24.png){width="3.375in" height="0.375in"}

在Blender菜单栏中选择文件→导入→FBX格式

![](./images/media/image25.png){width="4.385416666666667in"
height="5.385416666666667in"}

在弹出的导入选项对话框中，在最上方选择好刚才保存的路径，在中间文件列表中选择刚才保存的动作文件，在右侧的导入选项中，确保勾选了动画选项，然后点击右下角的导入
FBX按钮。

![](./images/media/image26.png){width="7.791666666666667in"
height="5.666666666666667in"}

导入成功后，可以看到场景的角色模型不再是默认的TPose姿态，并且下方的动画轨道中也有动画数据，调整动画轨道右上角的End结束帧的值到大于实际动画的帧数，例如1000等，然后按下空格键或者动画轨道上的播放按钮，即可回放录制的动作

![](./images/media/image27.png){width="6.5625in"
height="0.4479166666666667in"}

[请至钉钉文档查看附件《12345432345543.mp4》](https://alidocs.dingtalk.com/i/nodes/GZLxjv9VGGPdYEjbHOn5o9dgV6EDybno?iframeQuery=anchorId%3DX02m4l2xb13zv7oc33535d)

**4、实时重定向驱动或录制动画重定向**

**1）添加模型实时重定向驱动**

**①. blender插件与Motion Studio连接**

MotionStudio-数据广播中设置对应的ip地址及端口号

![](./images/media/image28.png){width="7.791666666666667in"
height="4.188020559930009in"}

在blender中设置与MS对应的ip和端口后，点击连接按钮，可开启动作同步

![](./images/media/image29.png){width="7.791666666666667in"
height="4.3213888888888885in"}

**②. 导入重定向模型（以FBX文件为例）**

成功连接MS后，重定向设置面板显示如下：（其中源角色为用来驱动重定向目标角色的来源角色，如果MS中有多个角色，可以在下拉框中切换驱动角色源）

![](./images/media/image30.png){width="3.5104166666666665in"
height="5.28125in"}

通过菜单栏File→Import→FBX，打开导入FBX选项面板

![](./images/media/image25.png){width="4.385416666666667in"
height="5.385416666666667in"}

在文件列表中选择需要驱动的目标角色模型文件（以HCR为例，此模型与默认角色有相同的初始TPose姿态以及相似的骨骼架构），确认右侧导入选项后，点击下方Import
FBX按钮导入到场景中。

![](./images/media/image31.png){width="7.052083333333333in"
height="5.479166666666667in"}

导入之后可以看到角色为 TPose 姿态

![](./images/media/image32.png){width="5.8125in" height="6.25in"}

**③. 点击场景列表中的显示按钮，隐藏骨骼显示**

![](./images/media/image33.png){width="4.427083333333333in"
height="0.59375in"}

![](./images/media/image34.png){width="5.4375in" height="7.15625in"}

**④. 添加重定向目标角色**

在重定向设置面板中，可以看到刚才导入的模型已经更新到了候选重定向角色列表中了，点击列表右侧的\>按钮可以将该角色添加到当前源角色的重定向目标角色列表中

![](./images/media/image35.png){width="2.46875in" height="5.625in"}

添加后，右侧列表中将更新，并且下方出现建立骨骼映射表按钮。

![](./images/media/image36.png){width="2.6145833333333335in"
height="2.1354166666666665in"}

**⑤. 设置骨骼映射**

点击建立骨骼映射表按钮，将建立骨骼映射表，点击下方保存骨骼映射表按钮，可以开启对该目标角色的实时重定向驱动。

![](./images/media/image37.png){width="3.1145833333333335in"
height="4.208333333333333in"}

位置1：显示当前驱动的源角色名称和重定向目标角色的名称。

位置2：列表分栏显示了源角色的骨骼列表和对应的目标角色的骨骼列表，如果目标骨骼的命名符合源角色的命名，则目标角色的映射骨骼能够自动匹配成功，如上图所示。

位置3：如果有任何骨骼映射不正确，可以选择该骨骼，然后再下方的下拉框中选择与源骨骼对应的目标骨骼（其中Root根骨骼可以不用设置，保持None即可）。

位置4：设置好对应的目标后，点击下方保存骨骼映射表按钮，可以开启对该目标角色的实时重定向驱动。

**⑥. 删除重定向目标角色**

如果不再需要驱动该重定向目标，可以在重定向目标角色列表中选择要移除的角色，点击列表中间的删除🗑️按钮，可以删除该重定向角色。

![](./images/media/image38.png){width="3.78125in"
height="1.8333333333333333in"}

**2）录制动画重定向驱动**

**①. 按照使用Auto-Rig-Pro插件**

需要将录制好的动画文件重定向到其他角色上时，需要使用blender的Auto-Rig-Pro(https://blendermarket.com/products/auto-rig-pro)重定向插件（请注意安装的blender版本与auto-rig-pro插件的版本）。

下载并安装好Auto-Rig-Pro插件后，可以在插件侧边栏看到ARP页签，点击可以打开Auto-Rig-Pro插件。

![](./images/media/image39.png){width="2.5104166666666665in"
height="5.791666666666667in"}

我们主要用到的是插件中重定向的部分，可以点开Auto-Rig Pro:
Remap显示详细设置。

![](./images/media/image40.png){width="2.3854166666666665in"
height="5.354166666666667in"}

**②. 导入录制动画及其他角色驱动模型**

首先导入刚才保存的录制动画文件，记住要勾选Animation。

![](./images/media/image41.png){width="7.3125in"
height="6.385416666666667in"}

再选择需要驱动的其他角色模型，这里拿Mixamo上的XBot为例。

![](./images/media/image42.png){width="7.3125in"
height="6.364583333333333in"}

导入后场景中模型如下图：

![](./images/media/image43.png){width="6.9375in" height="8.5in"}

**③. 设置骨骼映射**

在ARP插件中分别选择Source Armature为录制的FBX文件，Target
Armature为刚导入的XBot。

![](./images/media/image44.png){width="7.3125in" height="5.15625in"}

接下来点击Build Bones List按钮：

![](./images/media/image45.png){width="6.1875in"
height="9.229166666666666in"}

与实时重定向驱动中设置骨骼映射方式类似，[选择好于源骨骼对应的目标骨骼即可，注意要在Hips骨骼上选择勾选Set
as Root]{.mark}

[]{.mark}![](./images/media/image46.png){width="6.9375in"
height="7.083333333333333in"}[]{.mark}

然后点击Re-Target按钮，在弹出的选项中点击Ok按钮[。]{.mark}

[]{.mark}![](./images/media/image47.png){width="6.9375in"
height="2.7604166666666665in"}[]{.mark}

然后按下空格键播放即可看到重定向驱动的效果[。]{.mark}

[]{.mark}![](./images/media/image48.png){width="7.791666666666667in"
height="7.038968722659668in"}[]{.mark}
