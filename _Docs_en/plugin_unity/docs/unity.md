**Unity Plugin User Guide**

**I. Using Unity Software**

**1. Open Unity Hub (if not installed, download it from the official website:** <https://unity.cn/releases>**)**
![](./images/media/image1.png)

**2. Check whether the editor is installed (**minimum supported version: 2019.1.0**)**
![](./images/media/image2.png)

If it is not installed, click the Install Unity Editor button, and install the editor through Unity Hub or download it from the official website (URL: <https://unity.cn/releases/full/2019>)

![](./images/media/image3.png)

**3. Create a new project or open an existing project**
![](./images/media/image4.png)

Create a new project
![](./images/media/image5.png)

After creating the project, the new project opens automatically
![](./images/media/image6.png)

**4. If warnings appear after opening, address them (skip this step if there are no warnings)**
![](./images/media/image7.png)

Click Window > Package Manager
![](./images/media/image8.png)

Click Visual Studio Editor > Update to 2.0.22
![](./images/media/image9.png)

After the update completes, close the dialog
![](./images/media/image10.png)

**5. Import the Unity plugin**

Download Unity plugin version 2.3.0

[mostechPlugin2.3.0.unitypackage](./assets/mostechPlugin2.3.0.unitypackage)

Drag the motionPlugin2.1.0 plugin file into Project > Assets
![](./images/media/image11.png)

Click the Import button
![](./images/media/image12.png)

**6. Drive the full-body device**

Click Assets > mostech > scenes
![](./images/media/image13.png)

Click Motion Animator Scene or Motion Transforms Scene
![](./images/media/image14.png)

In the Hierarchy, click MotionDriver
![](./images/media/image15.png)

In Inspector > Motion Source Manager (script), enter the IP and port corresponding to those in Motion
![](./images/media/image16.png)

Connect the device, then perform pose calibration
![](./images/media/image17.png)

Click Run to stream real-time data
![](./images/media/image18.png)

**7. Drive the data glove device**

Click Assets > mostech > scenes
![](./images/media/image19.png)

Click Motion Hand Scene
![](./images/media/image20.png)

In Inspector > Motion Source Manager (script), enter the IP and port corresponding to those in Motion
![](./images/media/image21.png)

Connect the device, then perform pose calibration
![](./images/media/image22.png)

Click Run to stream real-time data
![](./images/media/image23.png)

**8. Drive combined devices**

Select the same model as for the full-body device
![](./images/media/image24.png)

In Inspector > Motion Source Manager (script), enter the IP and port corresponding to those in Motion
![](./images/media/image25.png)

Combine the devices in Motion, then perform pose calibration
![](./images/media/image26.png)

Click Run to stream real-time data
![](./images/media/image27.png)

**9. Drive multiple devices**

In the Hierarchy, select Mostech-Robot and copy it
![](./images/media/image28.png)

In Inspector > Motion Instances, enter the corresponding number of models
![](./images/media/image29.png)

Click MotionDriver, then in Inspector > Motion Instances > Element0, Element1, select the corresponding Mostech-Robot
![](./images/media/image30.png)

Click Mostech-Robot, then in Inspector > Actor ID, enter different numbers
![](./images/media/image31.png)

Click Mostech-Robot, then in Inspector, adjust the model position by modifying x, y, z
![](./images/media/image32.png)
![](./images/media/image33.png)

After performing pose calibration in Motion, click Run in Unity
![](./images/media/image34.png)

**10. Drive multiple models with a single device set**

In the Hierarchy, select Mostech-Robot and copy it
![](./images/media/image28.png)

In Inspector > Motion Instances, enter the corresponding number of models
![](./images/media/image29.png)

Click MotionDriver, then in Inspector > Motion Instances > Element0, Element1, select the corresponding Mostech-Robot
![](./images/media/image30.png)

Click Mostech-Robot, then in Inspector > Actor ID, enter the same number
![](./images/media/image31.png)

Click Mostech-Robot, then in Inspector, adjust the model position by modifying x, y, z
![](./images/media/image32.png)
![](./images/media/image33.png)

After performing pose calibration in Motion, click Run in Unity
![](./images/media/image35.png)

**II. Using Data Broadcast in Motion Studio**

**1. Open Motion Studio**
![](./images/media/image36.png)

2. On the home page, you can create a new project or open an existing one
![](./images/media/image37.png)
![](./images/media/image38.png)

**3. After selecting a project, enter the capture page**
![](./images/media/image39.png)

**4. Enable data broadcast**

Click the function button in the upper-left corner > Data Broadcast
![](./images/media/image40.png)

Enable BVH broadcast (the port number can be any value)
![](./images/media/image41.png)
![](./images/media/image42.png)

**5. After data broadcast is enabled, offline data can be played back without a device connected**

View the file list, then double-click a data file to play it
![](./images/media/image43.png)

Play the file
![](./images/media/image44.png)

After configuring the Unity IP and port, click the Play button to play back offline data
![](./images/media/image45.png)

**6. After data broadcast is enabled, real-time data can be played back with a device connected**

Connect the receiver to the computer. When the device appears in the device list, click the Connect button to connect the device
![](./images/media/image46.png)

After a successful connection, put on the straps and devices in sequence according to the prompts
![](./images/media/image47.png)

Once worn, click Pose Calibration and follow the prompts to perform T-Pose, A-Pose, and OK-Pose (when a data glove device combination is used) calibration
![](./images/media/image48.png)
![](./images/media/image49.png)
![](./images/media/image50.png)

After configuring the Unity IP and port, click the Play button to play back real-time data
![](./images/media/image51.png)
![](./images/media/image52.png)
