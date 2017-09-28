//
//  ViewController.swift
//  QRCode Reader
//
//  Created by Johnny Wang on 2017/9/22.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var detectionView: UIView?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        setCaptureSessionInput(captureSession: &captureSession!)
        setCaptureSessionOutput(captureSession: &captureSession!)
        setCaptureVideoPreviewLayer(captureSession: &captureSession!, previewView: &view!)
        initialDetectionView()
        refreshMessageLabel()
    }

    func setCaptureVideoPreviewLayer(captureSession: inout AVCaptureSession, previewView: inout UIView) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = previewView.layer.bounds
        previewView.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
    
    func setCaptureSessionInput(captureSession: inout AVCaptureSession) {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    func setCaptureSessionOutput(captureSession: inout AVCaptureSession) {
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.aztec, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.dataMatrix, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.interleaved2of5, AVMetadataObject.ObjectType.itf14, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr]
    }
    
    func initialDetectionView() {
        detectionView = UIView(frame: CGRect.zero)
        detectionView?.layer.borderColor = UIColor.orange.cgColor
        detectionView?.layer.borderWidth = 3
        view.addSubview(detectionView!)
        view.bringSubview(toFront: detectionView!)
    }
    
    func refreshDetectionView() {
        detectionView?.frame = CGRect.zero
    }
    
    func refreshMessageLabel() {
        messageLabel.text = "---------------"
        view.bringSubview(toFront: messageLabel)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj ) as! AVMetadataMachineReadableCodeObject
            detectionView?.frame = barCodeObject.bounds;
            
            messageLabel.text = metadataObj.stringValue
        } else {
            refreshDetectionView()
            refreshMessageLabel()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

