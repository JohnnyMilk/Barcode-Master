# Barcode-Master
A generic reader for Barcode and QR Code metadata. (Swift 4, iOS 11, Xcode 9)


# Result
![image][result]


# Emphasis
- Add the AVFoundation.framework in the project.
- The code `captureSession.addOutput` must be placed before the code `captureMetadataOutput.metadataObjectTypes` setting.
- Needing to create a `Privacy - Camera Usage Description` record in the `info.plist` file.


[result]:https://github.com/JohnnyMilk/Barcode-Master/blob/master/result.jpg
