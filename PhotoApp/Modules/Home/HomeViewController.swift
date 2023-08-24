//
//  HomeViewController.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var garbageButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()

        garbageButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(tapGarbage(_:)))
        
        self.navigationItem.rightBarButtonItem = garbageButton

    }
    
    @objc private func tapGarbage(_ sender: UIBarButtonItem) {
        
        print("hoge")
        let vc = ReadQRViewController.loadStoryboard()
        self.present(vc, animated: true)

    }
    

}
