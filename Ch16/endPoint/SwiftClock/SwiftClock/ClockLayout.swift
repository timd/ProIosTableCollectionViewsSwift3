//
//  ClockLayout.swift
//  SwiftClock
//
//  Created by Tim on 23/04/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ClockLayout: UICollectionViewLayout {
    
    fileprivate var clockTime: Date!
    fileprivate let dateFormatter = DateFormatter()

    fileprivate var timeHours: Int!
    fileprivate var timeMinutes: Int!
    fileprivate var timeSeconds: Int!
    
    var minuteHandSize: CGSize!
    var secondHandSize: CGSize!
    var hourHandSize: CGSize!
    var hourLabelCellSize: CGSize!

    fileprivate var clockFaceRadius: CGFloat!
    fileprivate var cvCenter: CGPoint!
    
    fileprivate var attributesArray = [UICollectionViewLayoutAttributes]()
    
    // MARK:
    // MARK: UICollectionViewLayout functions
    
    override func prepare() {
        
        cvCenter = CGPoint(x: collectionView!.frame.size.width/2, y: collectionView!.frame.size.height/2)
        
        clockTime = Date()
        
        dateFormatter.dateFormat = "HH"
        let hourString = dateFormatter.string(from: clockTime)
        timeHours = Int(hourString)!

        dateFormatter.dateFormat = "mm"
        let minString = dateFormatter.string(from: clockTime)
        timeMinutes = Int(minString)!

        dateFormatter.dateFormat = "ss"
        let secString = dateFormatter.string(from: clockTime)
        timeSeconds = Int(secString)!
        
        clockFaceRadius = min(cvCenter.x, cvCenter.y)
        
        calculateAllAttributes()

    }
    
    override var collectionViewContentSize : CGSize {
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // return the item from attributesArray with the matching indexPath

        return attributesArray.filter({ (theAttribute) -> Bool in
            theAttribute.indexPath == indexPath
        }).first
        
    }

    // MARK:
    // MARK: Unused UICollectionViewLayout function
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        // Will not get called by this layout, as there are no decoration views involved
        return nil
        
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        // Will not get called by this layout, as there are no supplementary views involved
        return nil
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        // Default value is false
        return false
        
    }

    // MARK:
    // MARK: Custom clock layout functions
    
func calculateAllAttributes() {
    
    for section in 0..<collectionView!.numberOfSections {
    
        for item in 0..<collectionView!.numberOfItems(inSection: section) {
        
            // Create index path for this item
            let indexPath = IndexPath(item: item, section: section)
            
            // Calculate the attributes
            let attributes = calculateAttributesForItemAt(indexPath)
            
            // Update or insert the newAttributes into the attributesArray
            if let matchingAttributeIndex = attributesArray.index( where: { (attributes: UICollectionViewLayoutAttributes ) -> Bool in
                (attributes.indexPath as NSIndexPath).compare(indexPath) == ComparisonResult.orderedSame
            }) {
    
                // Attribute already existed, therefore replace it
                attributesArray[matchingAttributeIndex] = attributes
    
            } else {
    
                // New set of attributes required
                attributesArray.append(attributes)
                
            }

        }
        
    }

}
    
    func calculateAttributesForItemAt(_ itemPath: IndexPath) -> UICollectionViewLayoutAttributes {
        
        var newAttributes = UICollectionViewLayoutAttributes(forCellWith: itemPath)
        
        if itemPath.section == 0 {
            newAttributes = calculateAttributesForHandCellAt(itemPath)
        }

        if itemPath.section == 1 {
            newAttributes = calculateAttributesForHourLabelWith(itemPath)
        }
        
        return newAttributes
        
    }
    
    func calculateAttributesForHourLabelWith(_ hourPath: IndexPath) -> UICollectionViewLayoutAttributes {
        
        // Create new instance of UICollectionViewLayoutAttributes
        let attributes = UICollectionViewLayoutAttributes(forCellWith: hourPath)
        
        // Calculate overall size of hour label
        attributes.size = hourLabelCellSize
        
        // Calculate the rotation per hour around the clock face
        let angularDisplacement: Double = (2 * M_PI) / 12
        
        let theta = angularDisplacement * Double(hourPath.row)
        
        let xDisplacement = sin(theta) * Double(clockFaceRadius - (attributes.size.width / 2))

        let yDisplacement = cos(theta) * Double(clockFaceRadius - (attributes.size.height / 2))
        
        let xPosition = cvCenter.x + CGFloat(xDisplacement)

        let yPosition = cvCenter.y - CGFloat(yDisplacement)

        let center: CGPoint = CGPoint(x: xPosition, y: yPosition)

        attributes.center = center
        
        return attributes
        
    }
    
    func calculateAttributesForHandCellAt(_ handPath: IndexPath) -> UICollectionViewLayoutAttributes {

        let attributes = UICollectionViewLayoutAttributes(forCellWith: handPath)
        
        let rotationPerHour: Double = (2 * M_PI) / 12
        
        let rotationPerMinute: Double = (2 * M_PI) / 60.0
        
        switch handPath.row {
            
        case 0: // handle hour hands

            attributes.size = hourHandSize
            attributes.center = cvCenter
            
            let intraHourRotationPerMinute: Double = rotationPerHour / 60
            
            let currentIntraHourRotation: Double = intraHourRotationPerMinute * Double(timeMinutes)
            
            let angularDisplacement = (rotationPerHour * Double(timeHours)) + currentIntraHourRotation
            
            attributes.transform = CGAffineTransform(rotationAngle: CGFloat(angularDisplacement))
            
        case 1: // handle minute hands

            attributes.size = minuteHandSize
            attributes.center = cvCenter
            
            let intraMinuteRotationPerSecond: Double = rotationPerMinute / 60
            
            let currentIntraMinuteRotation: Double = intraMinuteRotationPerSecond * Double(timeSeconds)
            
            let angularDisplacement = (rotationPerMinute * Double(timeMinutes)) + currentIntraMinuteRotation
            
            attributes.transform = CGAffineTransform(rotationAngle: CGFloat(angularDisplacement))
            
        case 2: // handle second hands

            attributes.size = secondHandSize
            attributes.center = cvCenter
            
            let angularDisplacement = rotationPerMinute * Double(timeSeconds)
            
            attributes.transform = CGAffineTransform(rotationAngle: CGFloat(angularDisplacement))
            
        default:
            break
            
        }
        
        return attributes

    }

}
