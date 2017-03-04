//
//  ButtonCell.swift
//  InCellDelegate
//
//  Created by Tim on 15/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    var delegate: InCellButtonProtocol?

    func didTapButton(_ sender: AnyObject) {
        if let delegate = delegate {
            delegate.didTapButtonInCell(self)
        }
    }
    
override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    let button = UIButton(type: UIButtonType.roundedRect)
    button.tag = 1000
    button.setTitle("Tap me!", for: UIControlState())
    button.sizeToFit()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self, action: #selector(ButtonCell.didTapButton(_:)), for: UIControlEvents.touchUpInside)
    
    //        button.addTarget(cell, action: "didTapButtonInCell", forControlEvents: UIControlEvents.TouchUpInside)
    
    let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerY, relatedBy:
        NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
    
    let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0)
    
    self.contentView.addSubview(button)
    self.contentView.addConstraints([vConstraint, hConstraint])

}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
