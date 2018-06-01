# Barcode-Master
A generic reader for Barcode and QR Code metadata. (Swift 4, iOS 11, Xcode 9)

[Related Website][Reference]

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
[Reference]:https://medium.com/the-furnace/%E8%A3%BD%E4%BD%9C%E8%88%87%E8%BE%A8%E8%AD%98-qr-code-%E5%92%8C-barcode-%E7%9A%84%E6%96%B9%E6%B3%95-ea93bccea10a
