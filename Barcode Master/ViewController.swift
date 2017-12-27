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
    @IBOutlet weak var messageLabel: UILabel!
    
    private var myBarcodeReader: MLBarcodeReader?
    private var detectedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDetectionView()
        myBarcodeReader = MLBarcodeReader(previewView: &view)
        view.bringSubview(toFront: messageLabel)
        myBarcodeReader?.delegate = self
        myBarcodeReader?.startRunning()
        view.bringSubview(toFront: detectedView!)
    }

    private func initDetectionView() {
        detectedView = UIView(frame: CGRect.zero)
        detectedView?.layer.borderColor = UIColor.orange.cgColor
        detectedView?.layer.borderWidth = 3
        view.addSubview(detectedView!)
    }
    
    func metadataResult(captured: Bool, value: String?, bound: CGRect) {
        detectedView?.frame = bound
        messageLabel.text = captured ? value : "---------------"
        view.bringSubview(toFront: messageLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

