# 快速创建虚拟直播模型

### 虚拟直播模型要求

模型要支持全身动捕+面捕

全身动捕模型需要有17个采集器对应的骨骼

![image.png](https://alidocs.oss-cn-zhangjiakou.aliyuncs.com/res/mPdnp86LAGVpnw98/img/5fa787d4-1296-49d8-a519-030df7d2a20f.png)

面部模型需要52个苹果ARkit标准的表情体(Blendshapes)，满足的越多表情越细腻。

![image.png](https://alidocs.oss-cn-zhangjiakou.aliyuncs.com/res/mPdnp86LAGVpnw98/img/4abaf67c-b5e9-4d72-a8df-df28c5031cd2.png)

### 快速创建满足全身动捕+面捕的模型

VRM格式模型说明:基于3D标准格式glTF2.0构建的，用于处理人形模型。由于VRM定义了人形角色，可以根据VRM中定义的人形骨骼来重现人形动作。VRM定义了标准的面部操作，例如"喜怒哀乐"、"眨眼"、"五十音"等

缺点:面部表情体(Blendshapes)较少，在面部捕捉时会没那么细腻。还需建模师二次开发，建模时间会大大缩短。

创建VRM格式的模型

方式一:通过VRoid Studio创建VMR模型

VRoid Studio: https://vroid.com/en/studio

VRoid Hub:  [https://hub.vroid.com/](https://hub.vroid.com/) 可以下载别人创作的VRM格式的模型

[请至钉钉文档查看附件《vroidStudio创建模型.mp4》](https://alidocs.dingtalk.com/i/nodes/NkDwLng8ZQZKkEl4s6XK0KoAJKMEvZBY?iframeQuery=anchorId%3DX02lrke0xqv3u7jua7zhxb)

方式二:通过HTC Avatar系统创建VRM模型

[https://avatar.viverse.com/zh-TW/avatar/what-is-vrm](https://avatar.viverse.com/zh-TW/avatar/what-is-vrm)

[请至钉钉文档查看附件《HTC Avatar.mp4》](https://alidocs.dingtalk.com/i/nodes/NkDwLng8ZQZKkEl4s6XK0KoAJKMEvZBY?iframeQuery=anchorId%3DX02lrkeb41odohn79y8rm)