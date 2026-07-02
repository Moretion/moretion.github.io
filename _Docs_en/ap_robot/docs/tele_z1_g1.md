# Unitree Teleoperation Demo Deployment

## Installing miniconda3

To avoid various version conflict issues, conda is recommended. Install it using the script below:

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

 

## Resolving Dependencies

Required dependencies: mujoco, meshcat, pinocchio

Note: Use Ubuntu 22 on the system to avoid version conflicts; the data processing frame rate is close to 20fps, while Ubuntu 24 only reaches 10fps. If conflicts occur, check whether numpy is below 2.0.

To speed up installation, you can use the Tsinghua mirror:

```shell
pip qinghua source: -i https://pypi.tuna.tsinghua.edu.cn/simple
```

Specific steps:

```shell
conda create -n mt python=3.10 pinocchio=3.1.0 numpy=1.26.4 -c conda-forge
conda activate mt

//Resolve dependencies
pip install mujoco 
pip install meshcat
conda install pinocchio -c conda-forge 
```

 

## Starting the Application

```shell
conda activate mt
cd Desktop/motionCapture_teleoperate/
python moxun_robot.py
```



## Notes

1. Unitree robots use DDS

2. The LAN segment must be set to: 192.168.123.X    

3. After verification with the Unitree simulation environment, the real robot behaves essentially the same

4. IMPORTANT: When calibrating the inertial device, the physical robot must be stopped

5. Use a Linux laptop; using a virtual machine is not recommended

6. The official AR open-source example is provided for operation

7. Remember to install unitree\_sdk2\_python



## Source Code

Contact the marketing colleagues.
