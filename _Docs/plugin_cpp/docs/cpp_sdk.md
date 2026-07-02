# C++SDK接口说明文档

## 简介

MotionReceiver 是一个用于接收动作捕捉数据的 C++ SDK，允许开发者通过网络连接获取实时动作数据。该 SDK 支持 TCP 和 UDP 协议，能够接收并解析动作捕捉设备传输的数据。

## 数据结构

MotionReceiver通过网络从MotionStudio获取BVH帧数据，每一帧中的 BVH 数据包含了 49 根骨骼的全部的动作数据。BVH仅包含人根节点的位移coordinate，不包含每个节点的位移数据。如有需要，联系销售。

### Vector3

表示三维空间中的坐标或旋转。

```c++
struct Vector3
{
    double x;  // X 轴坐标/旋转
    double y;  // Y 轴坐标/旋转
    double z;  // Z 轴坐标/旋转
};
```

### MotionData

单个设备的动作捕捉数据，包含完整的人体骨骼数据。

```c++
struct MotionData
{
    // 基本信息
    std::string actorName;         // 角色名称
    std::string deviceId;          // 设备ID
    std::string bvhRotationOrder;  // BVH旋转顺序
    Vector3 coordinate;            // 人总体位移

    // 躯干数据
    Vector3 crotch;                // 胯部
    Vector3 waistTwo;              // 腰部(上)
    Vector3 waistOne;              // 腰部(下)
    Vector3 back;                  // 背部
    Vector3 head;                  // 头部

    // 左肢体数据
    Vector3 leftShoulder;          // 左肩
    Vector3 leftUpperArm;          // 左上臂
    // ... 更多左肢体数据 ...

    // 右肢体数据
    Vector3 rightShoulder;         // 右肩
    Vector3 rightUpperArm;         // 右上臂
    // ... 更多右肢体数据 ...

    // 左手指数据
    Vector3 leftThumbUnder;        // 左拇指下部
    // ... 更多左手指数据 ...

    // 右手指数据
    Vector3 rightThumbUnder;       // 右拇指下部
    // ... 更多右手指数据 ...
};
```

### MotionDataList

包含多个设备的动作捕捉数据集合。

```c++
struct MotionDataList {
    MotionData* devices;  // 设备数据数组
    int count;            // 设备数量
};
```

## 函数接口

### 连接管理

#### Connect

```c++
API bool Connect(const char* address, unsigned port, bool useUdp);
```

**功能**: 连接到指定地址和端口的动作捕捉数据服务器。

**参数**:

* `address`: 服务器IP地址

* `port`: 服务器端口号

* `useUdp`: 是否使用UDP协议（true为UDP，false为TCP）

**返回值**:

* `true`: 连接成功

* `false`: 连接失败

#### IsRunning

```c++
API bool IsRunning();
```

**功能**: 获取当前连接状态。

**返回值**:

* `true`: 连接正常运行中

* `false`: 连接未建立或已断开

#### Disconnect

```c++
API void Disconnect();
```

**功能**: 断开与服务器的连接。

**返回值**: 无

### 数据获取

#### GetData

```c++
API MotionDataList GetData();
```

**功能**: 获取当前帧的动作数据。

**返回值**: 包含所有连接设备的动作数据的 `MotionDataList` 结构体。

## 使用示例

```c++
#include <iostream>
#include "include/Deserializer.h"
#include <conio.h> 
#include <thread>

int main()
{
    std::cout << "程序正在运行，按下Esc键退出程序。" << std::endl;

    // 循环尝试连接并获取数据
    while (true) {
        // 检查连接状态
        if (!IsRunning()) {
            // 连接到指定IP和端口，使用UDP协议
            Connect("192.168.2.24", 8888, true);
            std::this_thread::sleep_for(std::chrono::milliseconds(1000));
            std::cout << "连接中" << std::endl;
            continue;
        }

        // 获取动作数据
        auto data = GetData();
        if (data.count != 0) {
            // 处理获取到的数据
            // 例如: 遍历设备数据并使用
            for (int i = 0; i < data.count; i++) {
                MotionData& device = data.devices[i];
                // 使用device中的数据...
            }
        }

        // 其他处理逻辑...
    }

    // 断开连接
    Disconnect();
    return 0;
}
```

## 注意事项

1. 在使用前必须先调用 `Connect` 函数建立连接。

2. 建议在每次获取数据前通过 `IsRunning` 检查连接状态。

3. 如遇网络不稳定，可能需要实现自动重连机制。

4. 获取到的 `MotionDataList` 包含多个设备的数据，使用前应检查 `count` 值确保有效。

5. 使用完毕后，应调用 `Disconnect` 函数释放资源。

## 错误处理

SDK 中的函数会返回布尔值表示操作成功或失败。建议在生产环境中实现完善的错误处理机制，例如：

```c++
if (!Connect("192.168.2.24", 8888, true)) {
    std::cerr << "连接失败，请检查网络设置和服务器状态" << std::endl;
    // 错误处理逻辑...
}
```

## 附件A-BVH 数据头的样例

数据广播端口尚未提供对BVH头的查询命令，目前只能录制数据并导出BVH文件来查看。BVH头的骨骼长度会随动捕软件界面上的设置变化。

```c++
HIERARCHY
ROOT Motion_Hips
{
    OFFSET 0.000000 91.430000 0.000000
    CHANNELS 6 Xposition Yposition Zposition Xrotation Yrotation Zrotation
    JOINT Motion_RightUpLeg
    {
        OFFSET -9.250000 0.000000 0.000000
        CHANNELS 3 Xrotation Yrotation Zrotation
        JOINT Motion_RightLeg
        {
            OFFSET 0.000000 -41.870000 0.000000
            CHANNELS 3 Xrotation Yrotation Zrotation
            JOINT Motion_RightFoot
            {
                OFFSET 0.000000 -41.870000 0.000000
                CHANNELS 3 Xrotation Yrotation Zrotation
                End Site
                {
                    OFFSET 0.000000 -7.690000 14.000000
                }
            }
        }
    }
    JOINT Motion_LeftUpLeg
    {
        OFFSET 9.250000 0.000000 0.000000
        CHANNELS 3 Xrotation Yrotation Zrotation
        JOINT Motion_LeftLeg
        {
            OFFSET 0.000000 -41.870000 0.000000
            CHANNELS 3 Xrotation Yrotation Zrotation
            JOINT Motion_LeftFoot
            {
                OFFSET 0.000000 -41.870000 0.000000
                CHANNELS 3 Xrotation Yrotation Zrotation
                End Site
                {
                    OFFSET 0.000000 -7.690000 14.000000
                }
            }
        }
    }
    JOINT Motion_Spine
    {
        OFFSET 0.000000 7.817600 0.000000
        CHANNELS 3 Xrotation Yrotation Zrotation
        JOINT Motion_Spine1
        {
            OFFSET 0.000000 17.310400 0.000000
            CHANNELS 3 Xrotation Yrotation Zrotation
            JOINT Motion_Spine2
            {
                OFFSET 0.000000 12.284800 0.000000
                CHANNELS 3 Xrotation Yrotation Zrotation
                JOINT Motion_Neck
                {
                    OFFSET 0.000000 18.427200 0.000000
                    CHANNELS 3 Xrotation Yrotation Zrotation
                    JOINT Motion_Neck1
                    {
                        OFFSET 0.000000 4.735000 0.000000
                        CHANNELS 3 Xrotation Yrotation Zrotation
                        JOINT Motion_Head
                        {
                            OFFSET 0.000000 4.735000 0.000000
                            CHANNELS 3 Xrotation Yrotation Zrotation
                            End Site
                            {
                                OFFSET 0.000000 15.950000 0.000000
                            }
                        }
                    }
                }
                JOINT Motion_RightShoulder
                {
                    OFFSET -2.799888 12.843200 0.000000
                    CHANNELS 3 Xrotation Yrotation Zrotation
                    JOINT Motion_RightArm
                    {
                        OFFSET -13.200112 0.000000 0.000000
                        CHANNELS 3 Xrotation Yrotation Zrotation
                        JOINT Motion_RightForeArm
                        {
                            OFFSET -26.500000 0.000000 0.000000
                            CHANNELS 3 Xrotation Yrotation Zrotation
                            JOINT Motion_RightHand
                            {
                                OFFSET -26.000000 0.000000 0.000000
                                CHANNELS 3 Xrotation Yrotation Zrotation
                                JOINT Motion_RightHandThumb1
                                {
                                    OFFSET -1.841994 -0.460998 2.394992
                                    CHANNELS 3 Xrotation Yrotation Zrotation
                                    JOINT Motion_RightHandThumb2
                                    {
                                        OFFSET -3.681994 0.000000 0.000000
                                        CHANNELS 3 Xrotation Yrotation Zrotation
                                        JOINT Motion_RightHandThumb3
                                        {
                                            OFFSET -2.558996 0.000000 0.000000
                                            CHANNELS 3 Xrotation Yrotation Zrotation
                                            End Site
                                            {
                                                OFFSET -2.412997 0.000000 0.000000
                                            }
                                        }
                                    }
                                }
                                JOINT Motion_RightHandIndex
                                {
                                    OFFSET -3.224000 0.507999 1.978001
                                    CHANNELS 3 Xrotation Yrotation Zrotation
                                    JOINT Motion_RightHandIndex1
                                    {
                                        OFFSET -5.216997 -0.091000 0.998951
                                        CHANNELS 3 Xrotation Yrotation Zrotation
                                        JOINT Motion_RightHandIndex2
                                        {
                                            OFFSET -3.620008 0.000000 0.000000
                                            CHANNELS 3 Xrotation Yrotation Zrotation
                                            JOINT Motion_RightHandIndex3
                                            {
                                                OFFSET -2.052005 0.000000 0.000000
                                                CHANNELS 3 Xrotation Yrotation Zrotation
                                                End Site
                                                {
                                                    OFFSET -1.805006 0.000000 0.000000
                                                }
                                            }
                                        }
                                    }
                                }
                                JOINT Motion_RightHandMiddle
                                {
                                    OFFSET -3.381992 0.517999 0.756998
                                    CHANNELS 3 Xrotation Yrotation Zrotation
                                    JOINT Motion_RightHandMiddle1
                                    {
                                        OFFSET -5.174003 -0.084000 0.314000
                                        CHANNELS 3 Xrotation Yrotation Zrotation
                                        JOINT Motion_RightHandMiddle2
                                        {
                                            OFFSET -3.949000 0.000000 0.000000
                                            CHANNELS 3 Xrotation Yrotation Zrotation
                                            JOINT Motion_RightHandMiddle3
                                            {
                                                OFFSET -2.475999 0.000000 0.000000
                                                CHANNELS 3 Xrotation Yrotation Zrotation
                                                End Site
                                                {
                                                    OFFSET -1.975000 0.000000 0.000000
                                                }
                                            }
                                        }
                                    }
                                }
                                JOINT Motion_RightHandRing
                                {
                                    OFFSET -3.366001 0.538001 -0.128999
                                    CHANNELS 3 Xrotation Yrotation Zrotation
                                    JOINT Motion_RightHandRing1
                                    {
                                        OFFSET -4.635003 -0.021998 -0.479000
                                        CHANNELS 3 Xrotation Yrotation Zrotation
                                        JOINT Motion_RightHandRing2
                                        {
                                            OFFSET -3.441994 0.000000 0.000000
                                            CHANNELS 3 Xrotation Yrotation Zrotation
                                            JOINT Motion_RightHandRing3
                                            {
                                                OFFSET -2.387996 0.000000 0.000000
                                                CHANNELS 3 Xrotation Yrotation Zrotation
                                                End Site
                                                {
                                                    OFFSET -1.857004 0.000000 0.000000
                                                }
                                            }
                                        }
                                    }
                                }
                                JOINT Motion_RightHandPinky
                                {
                                    OFFSET -3.161007 0.470001 -1.202001
                                    CHANNELS 3 Xrotation Yrotation Zrotation
                                    JOINT Motion_RightHandPinky1
                                    {
                                        OFFSET -4.141006 -0.022001 -1.090998
                                        CHANNELS 3 Xrotation Yrotation Zrotation
                                        JOINT Motion_RightHandPinky2
                                        {
                                            OFFSET -2.756995 0.000000 0.000000
                                            CHANNELS 3 Xrotation Yrotation Zrotation
                                            JOINT Motion_RightHandPinky3
                                            {
                                                OFFSET -1.741997 0.000000 0.000000
                                                CHANNELS 3 Xrotation Yrotation Zrotation
                                                End Site
                                                {
                                                    OFFSET -1.644997 0.000000 0.000000
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                JOINT Motion_LeftShoulder
                {
                    OFFSET 2.799888 12.843200 0.000000
                    CHANNELS 3 Xrotation Yrotation Zrotation
                    JOINT Motion_LeftArm
                    {
                        OFFSET 13.200112 0.000000 0.000000
                        CHANNELS 3 Xrotation Yrotation Zrotation
                        JOINT Motion_LeftForeArm
                        {
                           OFFSET 26.500000 0.000000 0.000000
                           CHANNELS 3 Xrotation Yrotation Zrotation
                           JOINT Motion_LeftHand
                           {
                               OFFSET 26.500000 0.000000 0.000000
                               CHANNELS 3 Xrotation Yrotation Zrotation
                               JOINT Motion_LeftHandThumb1
                               {
                                   OFFSET 1.841994 -0.460998 2.394992
                                   CHANNELS 3 Xrotation Yrotation Zrotation
                                   JOINT Motion_LeftHandThumb2
                                   {
                                       OFFSET 3.681994 0.000000 0.000000
                                       CHANNELS 3 Xrotation Yrotation Zrotation
                                       JOINT Motion_LeftHandThumb3
                                       {
                                           OFFSET 2.558996 0.000000 0.000000
                                           CHANNELS 3 Xrotation Yrotation Zrotation
                                           End Site
                                           {
                                               OFFSET 2.412997 0.000000 0.000000
                                           }
                                       }
                                   }
                               }
                               JOINT Motion_LeftHandIndex
                               {
                                   OFFSET 3.224000 0.507999 1.978001
                                   CHANNELS 3 Xrotation Yrotation Zrotation
                                   JOINT Motion_LeftHandIndex1
                                   {
                                       OFFSET 5.216997 -0.091000 0.998951
                                       CHANNELS 3 Xrotation Yrotation Zrotation
                                       JOINT Motion_LeftHandIndex2
                                       {
                                           OFFSET 3.620008 0.000000 0.000000
                                           CHANNELS 3 Xrotation Yrotation Zrotation
                                           JOINT Motion_LeftHandIndex3
                                           {
                                               OFFSET 2.052005 0.000000 0.000000
                                               CHANNELS 3 Xrotation Yrotation Zrotation
                                               End Site
                                               {
                                                   OFFSET 1.805006 0.000000 0.000000
                                               }
                                           }
                                       }
                                   }
                               }
                               JOINT Motion_LeftHandMiddle
                               {
                                   OFFSET 3.381992 0.517999 0.756998
                                   CHANNELS 3 Xrotation Yrotation Zrotation
                                   JOINT Motion_LeftHandMiddle1
                                   {
                                       OFFSET 5.174003 -0.084000 0.314000
                                       CHANNELS 3 Xrotation Yrotation Zrotation
                                       JOINT Motion_LeftHandMiddle2
                                       {
                                           OFFSET 3.949000 0.000000 0.000000
                                           CHANNELS 3 Xrotation Yrotation Zrotation
                                           JOINT Motion_LeftHandMiddle3
                                           {
                                               OFFSET 2.475999 0.000000 0.000000
                                               CHANNELS 3 Xrotation Yrotation Zrotation
                                               End Site
                                               {
                                                   OFFSET 1.975000 0.000000 0.000000
                                               }
                                           }
                                       }
                                   }
                               }
                               JOINT Motion_LeftHandRing
                               {
                                   OFFSET 3.366001 0.538001 -0.128999
                                   CHANNELS 3 Xrotation Yrotation Zrotation
                                   JOINT Motion_LeftHandRing1
                                   {
                                       OFFSET 4.635003 -0.021998 -0.479000
                                       CHANNELS 3 Xrotation Yrotation Zrotation
                                       JOINT Motion_LeftHandRing2
                                       {
                                           OFFSET 3.441994 0.000000 0.000000
                                           CHANNELS 3 Xrotation Yrotation Zrotation
                                           JOINT Motion_LeftHandRing3
                                           {
                                               OFFSET 2.387996 0.000000 0.000000
                                               CHANNELS 3 Xrotation Yrotation Zrotation
                                               End Site
                                               {
                                                   OFFSET 1.857004 0.000000 0.000000
                                               }
                                           }
                                       }
                                   }
                               }
                               JOINT Motion_LeftHandPinky
                               {
                                   OFFSET 3.161007 0.470001 -1.202001
                                   CHANNELS 3 Xrotation Yrotation Zrotation
                                   JOINT Motion_LeftHandPinky1
                                   {
                                       OFFSET 4.141006 -0.022001 -1.090998
                                       CHANNELS 3 Xrotation Yrotation Zrotation
                                       JOINT Motion_LeftHandPinky2
                                       {
                                           OFFSET 2.756995 0.000000 0.000000
                                           CHANNELS 3 Xrotation Yrotation Zrotation
                                           JOINT Motion_LeftHandPinky3
                                           {
                                               OFFSET 1.741997 0.000000 0.000000
                                               CHANNELS 3 Xrotation Yrotation Zrotation
                                               End Site
                                               {
                                                   OFFSET 1.644997 0.000000 0.000000
                                               }
                                           }
                                       }
                                   }
                               }
                           }
                        }
                    }
                }
            }
        }
    }
}
```

## 附件B-Bone序列表

| 顺序  | MotionStudio骨骼定义       | BVH骨骼定义                  |
| --- | ---------------------- | ------------------------ |
| 1   | head                   | Motion\_Head             |
| 2   | back                   | Motion\_Neck             |
| 3   | crotch                 | Motion\_Hips             |
| 4   | leftShoulder           | Motion\_LeftShoulder     |
| 5   | leftUpperArm           | Motion\_LeftArm          |
| 6   | leftLowerArm           | Motion\_LeftForeArm      |
| 7   | leftHand               | Motion\_LeftHand         |
| 8   | leftUpperLeg           | Motion\_LeftUpLeg        |
| 9   | leftLowerLeg           | Motion\_LeftLeg          |
| 10  | leftFoot               | Motion\_LeftFoot         |
| 11  | rightShoulder          | Motion\_RightShoulder    |
| 12  | rightUpperArm          | Motion\_RightArm         |
| 13  | rightLowerArm          | Motion\_RightForeArm     |
| 14  | rightHand              | Motion\_RightHand        |
| 15  | rightUpperLeg          | Motion\_RightUpLeg       |
| 16  | rightLowerLeg          | Motion\_RightLeg         |
| 17  | rightFoot              | Motion\_RightFoot        |
| 18  | waistOne               | Motion\_Spine            |
| 19  | waistTwo               | Motion\_Spine1           |
| 20  | leftToe                | /                        |
| 21  | rightToe               | /                        |
| 22  | leftThumbUnder         | Motion\_LeftHandThumb1   |
| 23  | leftThumbMid           | Motion\_LeftHandThumb2   |
| 24  | leftThumbUp            | Motion\_LeftHandThumb3   |
| 25  | leftForeFingerUnder    | Motion\_LeftHandIndex1   |
| 26  | leftForeFingerMid      | Motion\_LeftHandIndex2   |
| 27  | leftForeFingerUp       | Motion\_LeftHandIndex3   |
| 28  | leftMiddleFingerUnder  | Motion\_LeftHandMiddle1  |
| 29  | leftMiddleFingerMid    | Motion\_LeftHandMiddle2  |
| 30  | leftMiddleFingerUp     | Motion\_LeftHandMiddle3  |
| 31  | leftRingFingerUnder    | Motion\_LeftHandRing1    |
| 32  | leftRingFingerMid      | Motion\_LeftHandRing2    |
| 33  | leftRingFingerUp       | Motion\_LeftHandRing3    |
| 34  | leftLittleFingerUnder  | Motion\_LeftHandPinky1   |
| 35  | leftLittleFingerMid    | Motion\_LeftHandPinky2   |
| 36  | leftLittleFingerUp     | Motion\_LeftHandPinky3   |
| 37  | rightThumbUnder        | Motion\_RightHandThumb1  |
| 38  | rightThumbMid          | Motion\_RightHandThumb2  |
| 39  | rightThumbUp           | Motion\_RightHandThumb3  |
| 40  | rightForeFingerUnder   | Motion\_RightHandIndex1  |
| 41  | rightForeFingerMid     | Motion\_RightHandIndex2  |
| 42  | rightForeFingerUp      | Motion\_RightHandIndex3  |
| 43  | rightMiddleFingerUnder | Motion\_RightHandMiddle1 |
| 44  | rightMiddleFingerMid   | Motion\_RightHandMiddle2 |
| 45  | rightMiddleFingerUp    | Motion\_RightHandMiddle3 |
| 46  | rightRingFingerUnder   | Motion\_RightHandRing1   |
| 47  | rightRingFingerMid     | Motion\_RightHandRing2   |
| 48  | rightRingFingerUp      | Motion\_RightHandRing3   |
| 49  | rightLittleFingerUnder | Motion\_RightHandPinky1  |
| 50  | rightLittleFingerMid   | Motion\_RightHandPinky2  |
| 51  | rightLittleFingerUp    | Motion\_RightHandPinky3  |
