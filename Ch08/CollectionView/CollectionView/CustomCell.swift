//
//  CustomCell.swift
//  CollectionView
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var cellTitle: String?
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let cellTitle = cellTitle {
            titleLabel.text = cellTitle
            subtitleLabel.text = "\(cellTitle)'s subtitle"
        }
        
    }
    
}

extension CustomCell {
    
func setupViews() {
    
    // Setup title label
    titleLabel = drawLabel()
    
    let vTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
    
    let hTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
    
    self.contentView.addSubview(titleLabel)
    
    // Setup subtitle label
    subtitleLabel = drawLabel()

    let hSubtitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)

    let vSubtitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 5)
    
    self.contentView.addSubview(subtitleLabel)
    

    self.contentView.backgroundColor = UIColor.cyan
    
    
    // Apply constraints
    self.contentView.addConstraints([vTitleConstraint, hTitleConstraint, hSubtitleConstraint, vSubtitleConstraint])
    
}
    
    func drawLabel() -> UILabel {
        let cellTitleLabel = UILabel(frame: CGRect.zero)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.sizeToFit()
        
        return cellTitleLabel
    }

}
