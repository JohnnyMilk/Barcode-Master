//
//  ViewController.swift
//  QRCode Reader
//
//  Created by Johnny Wang on 2017/9/22.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MLBarcodeReaderTextDelegate {
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var detectionView: UIView?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var myBarcodeReader: MLBarcodeReader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myBarcodeReader = MLBarcodeReader(previewView: &view)
        view.bringSubview(toFront: messageLabel)
        myBarcodeReader?.delegate = self
        myBarcodeReader?.startRunning()
    }

    func metadataResult(captured: Bool, value: String?) {
        messageLabel.text = captured ? value : "---------------"
        view.bringSubview(toFront: messageLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

