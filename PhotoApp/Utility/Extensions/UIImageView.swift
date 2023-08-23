//
//  UIImageView.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/19.
//

import Foundation
import UIKit

extension UIImageView {
    
    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
    }
}
