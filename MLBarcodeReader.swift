//
//  MLBarcodeReader.swift
//  Barcode Master
//
//  Created by Johnny Wang on 2017/9/28.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit
import AVFoundation

protocol MLBarcodeReaderTextDelegate {
    func metadataResult(captured: Bool, value: String?, bound: CGRect)
}

class MLBarcodeReader: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    var delegate: MLBarcodeReaderTextDelegate?
    
    init(previewView: inout UIView!) {
        super.init()
        
        captureSession = AVCaptureSession()
        setCaptureSessionInput(captureSession: &captureSession!)
        setCaptureSessionOutput(captureSession: &captureSession!)
        setCaptureVideoPreviewLayer(captureSession: &captureSession!, previewView: &previewView!)
    }
    
    func startRunning() {
        captureSession?.startRunning()
    }
    
    func stopRunning() {
        captureSession?.stopRunning()
    }
    
    private func setCaptureSessionInput(captureSession: inout AVCaptureSession) {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    private func setCaptureSessionOutput(captureSession: inout AVCaptureSession) {
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.aztec, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.dataMatrix, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.interleaved2of5, AVMetadataObject.ObjectType.itf14, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr]
    }
    
    private func setCaptureVideoPreviewLayer(captureSession: inout AVCaptureSession, previewView: inout UIView) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = previewView.layer.bounds
        previewView.layer.addSublayer(previewLayer!)
    }
    
    internal func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj ) as! AVMetadataMachineReadableCodeObject
            delegate?.metadataResult(captured: true, value: metadataObj.stringValue, bound: barCodeObject.bounds)
        } else {
            delegate?.metadataResult(captured: false, value: nil, bound: CGRect.zero)
        }
    }
}
