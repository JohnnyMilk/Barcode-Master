# Barcode-Master
A generic reader for Barcode and QR Code metadata. (Swift 4, iOS 11, Xcode 9)


# Result
![image][result]

# How to using
Given an UIView to present the camera preview in initial MLBarcodeReader.

```
var myBarcodeReader: MLBarcodeReader?
myBarcodeReader = MLBarcodeReader(previewView: &view)
myBarcodeReader?.startRunning()
```
### Capture Text
If you want to capture the text from the barcode, add the protocol `MLBarcodeReaderTextDelegate`.
And implement this function `func metadataResult(captured: Bool, value: String?)`.


### Stop Running
```
myBarcodeReader?.stotRunning()
```

# Don't Forget
- Add the AVFoundation.framework in the project.
- The code `captureSession.addOutput` must be placed before the code `captureMetadataOutput.metadataObjectTypes` setting.
- Needing to create a `Privacy - Camera Usage Description` record in the `info.plist` file.


[result]:https://github.com/JohnnyMilk/Barcode-Master/blob/master/result.jpg
