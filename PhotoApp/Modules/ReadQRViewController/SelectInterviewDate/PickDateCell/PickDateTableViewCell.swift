//
//  PickDateTableViewCell.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import UIKit

class PickDateTableViewCell: UITableViewCell {
    
    static let identifier = PickDateTableViewCell.className
    static func nib() -> UINib {
        return UINib(nibName: PickDateTableViewCell.className, bundle: nil)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(date: String, isOpen: Bool) {
        dateLabel.text = date
    }


    
}
