//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import Alamofire
import SwiftUI

final class SearchViewController: UIViewController {
    
    
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()

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

