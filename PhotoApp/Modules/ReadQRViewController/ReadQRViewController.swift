//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import AVFoundation
import SVProgressHUD

final class ReadQRViewController: UIViewController {
    
    private let session = AVCaptureSession()

    @IBOutlet private weak var caputureView: UIView!
    @IBOutlet private weak var prescriptionLabel: UILabel!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
        setUpViews()
        
    }
    
    private func setUpViews() {
        submitButton.addTarget(nil, action: #selector(submitButtonPressed), for: .touchUpInside)
        hideViews(isHidden: true)
    }
    
    @objc
    private func submitButtonPressed() {
        SVProgressHUD.show(withStatus: "送信中")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            SVProgressHUD.showSuccess(withStatus: "送信完了")
            let vc = SelectInterviewDateViewController.loadStoryboard()
            self.navigationController?.pushViewController(vc, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func hideViews(isHidden: Bool) {
        titleLabel.isHidden = isHidden
        prescriptionLabel.isHidden = isHidden
        submitButton.isHidden = isHidden
    }

}




extension ReadQRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    private func setUpCamera() {
        
        SVProgressHUD.showSuccess(withStatus: "処方箋のQRを読み込んでください。")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SVProgressHUD.dismiss()
        }
        
        //TODO: ここlabelでいい
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)

        let devices = discoverySession.devices
        if let backCamera = devices.first {
           do {
              // カメラでQRの読み取りに成功した時の処理
              let deviceInput = try AVCaptureDeviceInput(device: backCamera)
              doInit(deviceInput: deviceInput)
           } catch {
              print("Error occured while creating video device input: \(error)")
           }
        }
    }
    
    private func doInit(deviceInput: AVCaptureDeviceInput) {
        if !session.canAddInput(deviceInput) { return }
        session.addInput(deviceInput)
        let metadataOutput = AVCaptureMetadataOutput()
            
        if !session.canAddOutput(metadataOutput) { return }
        session.addOutput(metadataOutput)
            
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        // カメラを起動
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        caputureView.layer.addSublayer(previewLayer)
            
        session.startRunning()
    }

    internal func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            
       for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
           // QRのtype： metadata.type
           // QRの中身： metadata.stringValue
           guard let value = metadata.stringValue else { return }
                
           session.stopRunning()
           
           prescriptionLabel.text = value
           caputureView.isHidden = true
           
           SVProgressHUD.showSuccess(withStatus: "QRコードを読み取りました")
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               SVProgressHUD.dismiss()
           }
           
           hideViews(isHidden: false)
       }
    }
    
}
