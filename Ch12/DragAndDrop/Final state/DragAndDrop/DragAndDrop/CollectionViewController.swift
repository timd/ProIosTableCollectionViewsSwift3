//
//  CollectionViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ReuseIdentifier"

class CollectionViewController: UICollectionViewController {

    fileprivate let reuseIdentifier = "ReuseIdentifier"
    fileprivate var dataArray = [String]()
    fileprivate var selectedCell: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow drag-and-drop interaction
        self.installsStandardGestureForInteractiveMovement = true
        
        // Set up data
        for index in 0...100 {
            dataArray.append("\(index)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }

    // MARK: -
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        // Highlight the cell
        selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.red.cgColor

        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Find object to move
        let thingToMove = dataArray[sourceIndexPath.row]
        
        // Remove old object
        dataArray.remove(at: sourceIndexPath.row)
        
        // insert new copy of thing to move
        dataArray.insert(thingToMove, at: destinationIndexPath.row)
        
        // Set the cell's background to the original light grey
        selectedCell?.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Reload the data
        collectionView.reloadData()
        
    }

}
