//
//  UIButton.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/24.
//

import Foundation
import UIKit

extension UIButton {
    
    func circle() {
        layer.cornerRadius = min(bounds.size.height, bounds.size.width) / 2
    }
    
}
