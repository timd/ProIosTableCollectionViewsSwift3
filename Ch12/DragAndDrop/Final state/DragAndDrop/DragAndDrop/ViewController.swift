//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let reuseIdentifier = "ReuseIdentifier"
    fileprivate var dataArray = [String]()
    
    fileprivate var selectedCell: UICollectionViewCell?
    
    var panGesture: UIPanGestureRecognizer!
    var longPressGesture: UILongPressGestureRecognizer!
    var selectedIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up data
        for index in 0...100 {
            dataArray.append("\(index)")
        }
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(_:)))
        collectionView!.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongGesture(_:)))
        collectionView!.addGestureRecognizer(longPressGesture)
        longPressGesture.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
        case UIGestureRecognizerState.changed:
            break
        default:
            selectedIndexPath = nil
        }
        
    }
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath!)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

}

extension ViewController : UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        // Highlight the cell
        selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.red.cgColor
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
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

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == longPressGesture {
            return panGesture == otherGestureRecognizer
        }
        
        if gestureRecognizer == panGesture {
            return longPressGesture == otherGestureRecognizer
        }
        
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard gestureRecognizer == self.panGesture else {
            return true
        }
        
        return selectedIndexPath != nil
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.red.cgColor
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }

}



