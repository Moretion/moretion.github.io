# Streaming Port Protocol

The following is the documentation based on this JSON data:

## Streaming Data Description

This document describes a JSON-formatted streaming data payload that contains the pose information of each joint of the human body and the position of the root node. A client connects to the ServerSocket via a Socket connection and receives the data in JSON format.

### Data Format

The data format is JSON, as shown below:

```json
{
	"deviceList": [
      {
		"leftLittleFingerUnder": [0.0, 0.0, 0.0],
		"leftLowerLeg": [0.5283327317267245, 0.9699280975299531, 0.05361260659299393],
		"leftThumbMid": [0.0, 0.0, 0.0],
		"actorName": "36895272192031866103",
		"rightMiddleFingerMid": [0.0, 0.0, 0.0],
		"deviceId": "36895272192031866103",
		"leftToe": [0.0, 0.0, 0.0],
		"crotch": [167.57347163011366, -83.40422843226828, 168.32318812755344],
		"rightForeFingerUnder": [0.0, 0.0, 0.0],
		"leftThumbUnder": [0.0, 0.0, 0.0],
		"rightLowerLeg": [-0.14184703756515651, -0.3411541341866196, 0.11966295623743685],
		"rightMiddleFingerUnder": [0.0, 0.0, 0.0],
		"rightThumbMid": [0.0, 0.0, 0.0],
		"rightForeFingerMid": [0.0, 0.0, 0.0],
		"rightMiddleFingerUp": [0.0, 0.0, 0.0],
		"coordinate": [-0.701085451990366, 0.9399006068706512, 1.7706798166036606],
		"rightThumbUp": [0.0, 0.0, 0.0],
		"leftForeFingerMid": [0.0, 0.0, 0.0],
		"leftLowerArm": [-4.275193053831556, 6.029475112014665, 0.16694912669166465],
		"rightRingFingerMid": [0.0, 0.0, 0.0],
		"waistTwo": [0.29568526455187555, 35.644963830923615, -0.5573244587306913],
		"leftMiddleFingerUnder": [0.0, 0.0, 0.0],
		"leftMiddleFingerMid": [0.0, 0.0, 0.0],
		"rightLittleFingerMid": [0.0, 0.0, 0.0],
		"rightUpperLeg": [176.6885544428917, 72.91872796381254, -177.95669928739395],
		"leftForeFingerUnder": [0.0, 0.0, 0.0],
		"leftRingFingerUnder": [0.0, 0.0, 0.0],
		"leftLittleFingerUp": [0.0, 0.0, 0.0],
		"leftForeFingerUp": [0.0, 0.0, 0.0],
		"bvhRotationOrder": "XYZ",
		"rightLowerArm": [-121.27302739968908, -53.80513365787473, -79.57055095508167],
		"leftRingFingerMid": [0.0, 0.0, 0.0],
		"rightForeFingerUp": [0.0, 0.0, 0.0],
		"back": [0.29551572530026504, 35.6342730205439, -0.5570915211338497],
		"rightLittleFingerUp": [0.0, 0.0, 0.0],
		"rightRingFingerUnder": [0.0, 0.0, 0.0],
		"leftShoulder": [-0.18589438315193915, -0.9052612384769648, -0.5738650285131836],
		"head": [-0.03851023463838937, 0.7913068784451655, -0.7062768447186851],
		"leftUpperArm": [-2.2109214884746184, 0.7886943442852772, -33.677680182697486],
		"leftMiddleFingerUp": [0.0, 0.0, 0.0],
		"rightHand": [116.29463249250328, 50.96926853262847, -78.59930404908181],
		"rightFoot": [0.2060584982674821, 0.8379528867935927, -0.09795635155078423],
		"waistOne": [0.29551572530026504, 35.63427302054393, -0.5570915211338499],
		"leftUpperLeg": [178.28257488310416, 73.86704919190285, -179.49772684666087],
		"leftThumbUp": [0.0, 0.0, 0.0],
		"rightUpperArm": [2.7153986036959346, -0.9532830770749268, 33.639901563359864],
		"rightRingFingerUp": [0.0, 0.0, 0.0],
		"rightToe": [0.0, 0.0, 0.0],
		"leftLittleFingerMid": [0.0, 0.0, 0.0],
		"leftRingFingerUp": [0.0, 0.0, 0.0],
		"leftHand": [34.30087801348577, -36.18378054306241, 10.29834646689235],
		"leftFoot": [-0.3257049210066964, 1.284396122923064, 0.34588575015733],
		"rightShoulder": [-0.1527352626370245, 0.7979215521202965, -0.6612408963735164],
		"rightLittleFingerUnder": [0.0, 0.0, 0.0],
		"rightThumbUnder": [0.0, 0.0, 0.0]
	}, 
      {
		"leftLittleFingerUnder": [0.0, 0.0, 0.0],
		"leftLowerLeg": [-0.40573345247257264, -18.4634204946525, 0.2511509567285266],
		"leftThumbMid": [0.0, 0.0, 0.0],
		"actorName": "8780442582114229391",
		"rightMiddleFingerMid": [0.0, 0.0, 0.0],
		"deviceId": "8780442582114229391",
		"leftToe": [0.0, 0.0, 0.0],
		"crotch": [-0.2044930858509223, -39.26269365322497, -0.037041743724933796],
		"rightForeFingerUnder": [0.0, 0.0, 0.0],
		"leftThumbUnder": [0.0, 0.0, 0.0],
		"rightLowerLeg": [-0.1767339587597831, 3.9021207519650063, 0.49314465550116343],
		"rightMiddleFingerUnder": [0.0, 0.0, 0.0],
		"rightThumbMid": [0.0, 0.0, 0.0],
		"rightForeFingerMid": [0.0, 0.0, 0.0],
		"rightMiddleFingerUp": [0.0, 0.0, 0.0],
		"coordinate": [-0.06738789379596713, 0.9254053207114338, 0.06742429733276367],
		"rightThumbUp": [0.0, 0.0, 0.0],
		"leftForeFingerMid": [0.0, 0.0, 0.0],
		"leftLowerArm": [-0.08699000572472954, 0.6863571788756292, 0.11855827980903816],
		"rightRingFingerMid": [0.0, 0.0, 0.0],
		"waistTwo": [-0.015424130073108227, 0.055886741439810775, 0.026696603642111863],
		"leftMiddleFingerUnder": [0.0, 0.0, 0.0],
		"leftMiddleFingerMid": [0.0, 0.0, 0.0],
		"rightLittleFingerMid": [0.0, 0.0, 0.0],
		"rightUpperLeg": [0.42060291176478676, -2.1037899016837187, -0.1868693436966618],
		"leftForeFingerUnder": [0.0, 0.0, 0.0],
		"leftRingFingerUnder": [0.0, 0.0, 0.0],
		"leftLittleFingerUp": [0.0, 0.0, 0.0],
		"leftForeFingerUp": [0.0, 0.0, 0.0],
		"bvhRotationOrder": "XYZ",
		"rightLowerArm": [-0.16399108361481987, -0.11848358762031388, -0.03239584056380892],
		"leftRingFingerMid": [0.0, 0.0, 0.0],
		"rightForeFingerUp": [0.0, 0.0, 0.0],
		"back": [-0.015419499853539614, 0.05586997984781864, 0.02668859400377571],
		"rightLittleFingerUp": [0.0, 0.0, 0.0],
		"rightRingFingerUnder": [0.0, 0.0, 0.0],
		"leftShoulder": [0.5305371373965916, -0.4449699181562023, -0.9358010480478481],
		"head": [0.11915716369841646, 0.10442513581288657, -0.11235430434039644],
		"leftUpperArm": [-0.5747730532023467, 0.4200904612748533, -32.76454790349389],
		"leftMiddleFingerUp": [0.0, 0.0, 0.0],
		"rightHand": [-5.839335306133827, -7.834890734098407, 0.25703843613984406],
		"rightFoot": [-0.37335566172713364, -2.4396810057529454, -0.12317384133139211],
		"waistOne": [-0.01541949985353954, 0.05586997984781229, 0.02668859400377569],
		"leftUpperLeg": [0.07023596070865984, 17.845656318012665, 0.11397519757537351],
		"leftThumbUp": [0.0, 0.0, 0.0],
		"rightUpperArm": [0.6870520821370538, -2.0975935038200126, 31.78050481691975],
		"rightRingFingerUp": [0.0, 0.0, 0.0],
		"rightToe": [0.0, 0.0, 0.0],
		"leftLittleFingerMid": [0.0, 0.0, 0.0],
		"leftRingFingerUp": [0.0, 0.0, 0.0],
		"leftHand": [0.3254735259841174, -0.9885952909200776, -0.1923420038814004],
		"leftFoot": [0.329059431216289, 24.35541948578364, 0.029652081491475666],
		"rightShoulder": [-0.5753150002783762, 2.0401497415649117, 1.9198983633224964],
		"rightLittleFingerUnder": [0.0, 0.0, 0.0],
		"rightThumbUnder": [0.0, 0.0, 0.0]
	}]
}
```

### Data Content

The data contains the position information of each joint of the human body (expressed as three-dimensional coordinates). The following are the joint names and their corresponding coordinates:

*   `deviceId`: Device ID
    
*   `actorName`: Actor name
    
*   `leftLittleFingerUnder`: Left little finger, lower
    
*   `leftLittleFingerUnder`: Left little finger, lower
    
*   `leftLowerLeg`: Left lower leg
    
*   `leftThumbMid`: Left thumb, middle
    
*   `rightMiddleFingerMid`: Right middle finger, middle
    
*   `leftToe`: Left toe
    
*   `crotch`: Crotch
    
*   `rightForeFingerUnder`: Right index finger, lower
    
*   `leftThumbUnder`: Left thumb, lower
    
*   `rightLowerLeg`: Right lower leg
    
*   `rightMiddleFingerUnder`: Right middle finger, lower
    
*   `rightThumbMid`: Right thumb, middle
    
*   `rightForeFingerMid`: Right index finger, middle
    
*   `rightMiddleFingerUp`: Right middle finger, upper
    
*   `coordinate`: Coordinate
    
*   `rightThumbUp`: Right thumb, upper
    
*   `leftForeFingerMid`: Left index finger, middle
    
*   `leftLowerArm`: Left lower arm
    
*   `rightRingFingerMid`: Right ring finger, middle
    
*   `waistTwo`: Waist two
    
*   `leftMiddleFingerUnder`: Left middle finger, lower
    
*   `leftMiddleFingerMid`: Left middle finger, middle
    
*   `rightLittleFingerMid`: Right little finger, middle
    
*   `rightUpperLeg`: Right upper leg
    
*   `leftForeFingerUnder`: Left index finger, lower
    
*   `rightToe`: Right toe
    
*   `rightLowerArm`: Right lower arm
    
*   `rightRingFingerUnder`: Right ring finger, lower
    
*   `leftRingFingerUnder`: Left ring finger, lower
    
*   `leftRingFingerMid`: Left ring finger, middle
    
*   `rightMiddleFingerDown`: Right middle finger, down
    
*   `rightForeFingerUp`: Right index finger, upper
    
*   `rightRingFingerUp`: Right ring finger, upper
    
*   `leftMiddleFingerDown`: Left middle finger, down
    
*   `leftUpperLeg`: Left upper leg
    
*   `leftLittleFingerMid`: Left little finger, middle
    
*   `head`: Head
    
*   `leftForeFingerUp`: Left index finger, upper
    
*   `rightLittleFingerUp`: Right little finger, upper
    
*   `rightThumbUnder`: Right thumb, lower
    

Among these, `coordinate` represents the three-dimensional coordinate of the entire human body, and `bvhRotationOrder` indicates the rotation order.

The model uses a right-handed coordinate system with the X axis pointing right, the Y axis pointing up, and the Z axis pointing backward. The Euler angles are intrinsic rotation data.

Note that the data in this document is for example purposes only; the actual data in a real application may differ.

Note: When the `bvhRotationOrder` convention is XYZ, the element order in the array corresponding to each joint is also XYZ. Likewise, when the convention is ZXY, the element order in the array is also ZXY.

### Data Parsing

To parse the data, parse it according to the JSON format, then extract the corresponding coordinates based on the joint names.

## Reference

*   [Introduction to JSON](https://www.json.org/json-en.html)
    

## Specific Requirements

### [Streaming] API

### Common Error Codes

| **code value** | **Description** |
| --- | --- |
| 1001 | Parameter error; in this case, check `msg` for the specific error description |
|  |  |

### Query Device List

Request parameters:

| **Parameter** | **Required** | **Type** | **Description** |
| --- | --- | --- | --- |
| $.control | Yes | string | deviceList |
| $.nodeList | Yes | array | Integer array, e.g. `[1,2]`; the list of collectors numbered from 1, where `1` = left data glove, `2` = right data glove |

Return parameters:

| **Parameter** | **Required** | **Type** | **Description** |
| --- | --- | --- | --- |
| $.control | Yes | string | onDeviceList |
| $.code | Yes | int | Common error code; a return value of 1000 indicates success; |
| $.msg | Yes | string | Common error message, corresponding to the explanation of the `code` field; for example, when `code` returns `1000`, msg is `ok` |
| $.deviceList | Yes | array | Device list |
| $.deviceList.\[i\].productID | Yes | string | Device ID |
| $.deviceList.\[i\].name | Yes | string | Device name; currently formatted as "Device" + idex |
| $.deviceList.\[i\].channel | Yes | string | Device channel |
| $.deviceList.\[i\].modeName | Yes | string | Mode name, e.g. `Full-body mode` |
| $.deviceList.\[i\].actorName | Yes | string | Actor name; if not set or no project is open, the default is `Motion Robot`; when a project is open, this is the actor name corresponding to the project; |
| $.deviceList.\[i\].isConnected | Yes | boolean | Whether the device is connected; `true` means connected, `false` means not connected (e.g. powered off, in sleep mode, etc.); |
| $.deviceList.\[i\].createTime | Yes | string | Device creation timestamp, used for sorting and display; uses the string type to avoid loss of precision; |
| $.deviceList.\[i\].boneTemplateName | Yes | string | Bone template name, used to pass back when recording via the interface; |

### Wired Data Glove Motor Vibration Protocol

Request parameters:

| **Parameter** | **Required** | **Type** | **Description** |
| --- | --- | --- | --- |
| $.control | Yes | string | motorShake |
| $.deviceId | No | string | Device ID; in the first version, if the device list has not been obtained, this can be left empty; once the device list is available, it becomes required; |
| $.shakePattern | Yes | int | shakePattern - motor vibration pattern<br>                    shakePattern=0  vibrate 0.5s<br>                    shakePattern=1  vibrate 1s<br>                    shakePattern=2  vibrate 1.5s<br>                    shakePattern=3  vibrate 2s<br>                    shakePattern=4  vibrate 2.5s<br>and so on, up to 5 seconds supported |
| $.nodeList | Yes | array | Integer array, e.g. `[1,2]`; the list of collectors numbered from 1, where `1` = left data glove, `2` = right data glove |

Return parameters:

| **Parameter** | **Required** | **Type** | **Description** |
| --- | --- | --- | --- |
| $.control | Yes | string | onMotorShake |
| $.code | Yes | int | Common error code; a return value of 1000 indicates success |
| $.msg | Yes | string | Common error message, corresponding to the explanation of the `code` field; for example, when `code` returns `1000`, msg is `ok` |
| $.data | Yes | boolean | Operation result; `true` when `code=1000` |
