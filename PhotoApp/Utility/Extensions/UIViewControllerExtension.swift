//
//  UIViewControllerExtension.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/20.
//

import Foundation
import UIKit


protocol StoryBoardInstantiatable {}
extension UIViewController: StoryBoardInstantiatable {}

extension StoryBoardInstantiatable where Self: UIViewController {

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: self.className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }

    static func instantiate(withStoryboard storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}




extension UIViewController: StoryboardLoadable { }

protocol StoryboardLoadable { }

// swiftlint:disable force_cast
extension StoryboardLoadable where Self: UIViewController {
    static func loadStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.className, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }

    static func loadStoryboard(storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}
