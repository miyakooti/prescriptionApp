//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import Alamofire
import SwiftUI
import AVFoundation


final class SearchViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    private let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    private let metadataOutput = AVCaptureMetadataOutput()
    private let metadataObjectQueue = DispatchQueue(label: "metadataObjectQueue")
    
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break // 👍
        case .notDetermined:
            // 権限をリクエスト！
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    // 😭
                }
            }
        default:
            break
            // The user has previously denied access.
        }
        
        sessionQueue.async {
            self.configureSession()
        }
        
    }
    
    private func configureSession() {
        session.beginConfiguration()
        
        let defaultVideoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                         for: .video,
                                                         position: .back)
        
        guard let videoDevice = defaultVideoDevice else {
            session.commitConfiguration()
            return
        }
        
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
//                self.videoDeviceInput = videoDeviceInput
            }
        } catch {
            session.commitConfiguration()
            return
        }
        
        //configureSessionの続き
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: metadataObjectQueue)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            session.commitConfiguration()
        }
        
        session.commitConfiguration()
    }
    
    
    
    
    
    
    
    
    
    
    
    @objc
    private func onShouldCloseShade(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) {
            self.shadeView.alpha = 0
        } completion: { done in
            if done {
                self.shadeView.removeFromSuperview()
            }
        }
    }
    
    
    private func setUpViews() {
        UITabBar.appearance().tintColor = UIColor.init(hex: "7CC7E8")
        
    }
    
}

extension SearchViewController {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        for metadataObject in metadataObjects {
            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
                  machineReadableCode.type == .qr,
                  let stringValue = machineReadableCode.stringValue
            else {
                return
            }
            // QRコード読み取り成功🎉
            print("The content of QR code: \(stringValue)")
        }
    }
}
