# C++ SDK Interface Documentation

## Introduction

MotionReceiver is a C++ SDK for receiving motion capture data. It allows developers to obtain real-time motion data over a network connection. The SDK supports both TCP and UDP protocols, and can receive and parse data transmitted by motion capture devices.

## Data Structures

MotionReceiver obtains BVH frame data from Motion Studio over the network. The BVH data in each frame contains the complete motion data of all 49 bones. The BVH only includes the translation coordinate of the human root node; it does not include translation data for each individual node. If required, please contact sales.

### Vector3

Represents a coordinate or rotation in three-dimensional space.

```c++
struct Vector3
{
    double x;  // X-axis coordinate/rotation
    double y;  // Y-axis coordinate/rotation
    double z;  // Z-axis coordinate/rotation
};
```

### MotionData

Motion capture data for a single device, containing the complete human skeleton data.

```c++
struct MotionData
{
    // Basic information
    std::string actorName;         // Actor name
    std::string deviceId;          // Device ID
    std::string bvhRotationOrder;  // BVH rotation order
    Vector3 coordinate;            // Overall human translation

    // Torso data
    Vector3 crotch;                // Crotch
    Vector3 waistTwo;              // Waist (upper)
    Vector3 waistOne;              // Waist (lower)
    Vector3 back;                  // Back
    Vector3 head;                  // Head

    // Left limb data
    Vector3 leftShoulder;          // Left shoulder
    Vector3 leftUpperArm;          // Left upper arm
    // ... more left limb data ...

    // Right limb data
    Vector3 rightShoulder;         // Right shoulder
    Vector3 rightUpperArm;         // Right upper arm
    // ... more right limb data ...

    // Left finger data
    Vector3 leftThumbUnder;        // Left thumb (lower)
    // ... more left finger data ...

    // Right finger data
    Vector3 rightThumbUnder;       // Right thumb (lower)
    // ... more right finger data ...
};
```

### MotionDataList

A collection of motion capture data for multiple devices.

```c++
struct MotionDataList {
    MotionData* devices;  // Device data array
    int count;            // Number of devices
};
```

## Function Interface

### Connection Management

#### Connect

```c++
API bool Connect(const char* address, unsigned port, bool useUdp);
```

**Function**: Connects to a motion capture data server at the specified address and port.

**Parameters**:

* `address`: Server IP address

* `port`: Server port number

* `useUdp`: Whether to use the UDP protocol (true for UDP, false for TCP)

**Return value**:

* `true`: Connection succeeded

* `false`: Connection failed

#### IsRunning

```c++
API bool IsRunning();
```

**Function**: Gets the current connection status.

**Return value**:

* `true`: Connection is running normally

* `false`: Connection not established or disconnected

#### Disconnect

```c++
API void Disconnect();
```

**Function**: Disconnects from the server.

**Return value**: None

### Data Retrieval

#### GetData

```c++
API MotionDataList GetData();
```

**Function**: Retrieves the motion data of the current frame.

**Return value**: A `MotionDataList` structure containing the motion data of all connected devices.

## Usage Example

```c++
#include <iostream>
#include "include/Deserializer.h"
#include <conio.h> 
#include <thread>

int main()
{
    std::cout << "The program is running. Press Esc to exit." << std::endl;

    // Loop to attempt connection and retrieve data
    while (true) {
        // Check connection status
        if (!IsRunning()) {
            // Connect to the specified IP and port using the UDP protocol
            Connect("192.168.2.24", 8888, true);
            std::this_thread::sleep_for(std::chrono::milliseconds(1000));
            std::cout << "Connecting" << std::endl;
            continue;
        }

        // Retrieve motion data
        auto data = GetData();
        if (data.count != 0) {
            // Process the retrieved data
            // For example: iterate over device data and use it
            for (int i = 0; i < data.count; i++) {
                MotionData& device = data.devices[i];
                // Use the data in device...
            }
        }

        // Other processing logic...
    }

    // Disconnect
    Disconnect();
    return 0;
}
```

## Notes

1. You must call the `Connect` function to establish a connection before use.

2. It is recommended to check the connection status with `IsRunning` before each data retrieval.

3. In case of network instability, you may need to implement an automatic reconnection mechanism.

4. The retrieved `MotionDataList` contains data for multiple devices. You should check the `count` value before use to ensure validity.

5. After use, call the `Disconnect` function to release resources.

## Error Handling

Functions in the SDK return boolean values to indicate success or failure. It is recommended to implement a comprehensive error handling mechanism in production environments, for example:

```c++
if (!Connect("192.168.2.24", 8888, true)) {
    std::cerr << "Connection failed. Please check the network settings and server status." << std::endl;
    // Error handling logic...
}
```

## Appendix A - Sample BVH Data Header

The data broadcast port does not yet provide a command to query the BVH header. Currently, you can only record data and export a BVH file to view it. The bone lengths in the BVH header change according to the settings on the motion capture software interface.

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

## Appendix B - Bone Sequence Table

| Order | MotionStudio Bone Definition | BVH Bone Definition       |
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
