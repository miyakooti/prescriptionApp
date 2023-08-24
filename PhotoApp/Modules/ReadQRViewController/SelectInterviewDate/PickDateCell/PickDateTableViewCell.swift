//
//  PickDateTableViewCell.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import UIKit

final class PickDateTableViewCell: UITableViewCell {
    
    static let identifier = PickDateTableViewCell.className
    static func nib() -> UINib {
        return UINib(nibName: PickDateTableViewCell.className, bundle: nil)
    }
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var checkImage: UIImageView!
    @IBOutlet private weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(date: String, isOpen: Bool, indexPath: IndexPath, selectedIndexPath: IndexPath?) {
        
        dateLabel.text = date
        dateLabel.text = date
        selectionStyle = .none
        
        if indexPath == selectedIndexPath {
            checkImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            checkImage.image = UIImage(systemName: "circle")
        }
    }
    


    
}
