//
//  ViewController.swift
//  Trackr
//
//  Created by Tim Duckett on 05/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class SizingViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var cvData = [Int]()
    
    var minCellHeight: CGFloat!
    var maxCellHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupData()
        setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SizingViewController {
    
    func setupData() {
        for index in 0...20 {
            cvData.append(index)
        }
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
        maxCellHeight = min(collectionView.frame.size.width, collectionView.frame.size.height) / 2
        minCellHeight = layout.itemSize.height
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(SizingViewController.didGetPinchGesture(_:)))
        collectionView.addGestureRecognizer(pinchRecognizer)
        
    }
    
    func didGetPinchGesture(_ sender: UIPinchGestureRecognizer) {
        
        guard sender.numberOfTouches == 2 else {
            return
        }
        
        let pointOne = sender.location(ofTouch: 0, in: collectionView)
        let pointTwo = sender.location(ofTouch: 1, in: collectionView)
        
        let dX = pointOne.x - pointTwo.x
        let dY = pointTwo.y - pointTwo.y
        
        let distance = sqrt(dX * dX + dY * dY)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let adjustmentFactor = distance / min(collectionView.frame.size.width, collectionView.frame.size.height)
        let proposedCellHeight = layout.itemSize.height * adjustmentFactor + 75
        layout.itemSize = CGSize(width: proposedCellHeight, height: proposedCellHeight)
        
        layout.invalidateLayout()
        
    }
}

extension SizingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = "Cell \(cvData[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.cyan.cgColor
        cell.contentView.layer.borderWidth = 2.0
        return cell
    }
    
}

