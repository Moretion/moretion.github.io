# Quickly Create a Virtual Live Streaming Model

### Virtual Live Streaming Model Requirements

The model must support full-body motion capture plus facial capture.

The full-body motion capture model requires a skeleton corresponding to 17 collectors.

![image.png](https://alidocs.oss-cn-zhangjiakou.aliyuncs.com/res/mPdnp86LAGVpnw98/img/5fa787d4-1296-49d8-a519-030df7d2a20f.png)

The facial model requires 52 Apple ARKit-standard blendshapes; the more of these that are satisfied, the more refined the facial expressions will be.

![image.png](https://alidocs.oss-cn-zhangjiakou.aliyuncs.com/res/mPdnp86LAGVpnw98/img/4abaf67c-b5e9-4d72-a8df-df28c5031cd2.png)

### Quickly Create a Model That Supports Full-Body Motion Capture Plus Facial Capture

Notes on the VRM format model: It is built on the 3D standard format glTF2.0 and is used to handle humanoid models. Because VRM defines a humanoid character, humanoid motions can be reproduced based on the humanoid skeleton defined in VRM. VRM defines standard facial operations, such as "joy, anger, sorrow, and pleasure", "blinking", "the fifty sounds of the Japanese syllabary", and so on.

Drawbacks: The number of blendshapes is relatively small, so facial capture will be less refined. Modelers still need to perform secondary development, though modeling time will be greatly reduced.

Creating a VRM format model

Method 1: Create a VRM model via VRoid Studio

VRoid Studio: https://vroid.com/en/studio

VRoid Hub: [https://hub.vroid.com/](https://hub.vroid.com/) — you can download VRM format models created by others.

[See the attachment "vroidStudio创建模型.mp4" on the DingTalk document](https://alidocs.dingtalk.com/i/nodes/NkDwLng8ZQZKkEl4s6XK0KoAJKMEvZBY?iframeQuery=anchorId%3DX02lrke0xqv3u7jua7zhxb)

Method 2: Create a VRM model via the HTC Avatar system

[https://avatar.viverse.com/zh-TW/avatar/what-is-vrm](https://avatar.viverse.com/zh-TW/avatar/what-is-vrm)

[See the attachment "HTC Avatar.mp4" on the DingTalk document](https://alidocs.dingtalk.com/i/nodes/NkDwLng8ZQZKkEl4s6XK0KoAJKMEvZBY?iframeQuery=anchorId%3DX02lrkeb41odohn79y8rm)
