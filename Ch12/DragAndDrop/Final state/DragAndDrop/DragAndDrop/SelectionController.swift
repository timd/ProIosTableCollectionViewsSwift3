//
//  CollectionViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

protocol CustomMenuDelegate {
    func performDestroy(_ sender: AnyObject, forCell:SelectionCell)
    func addItem(_ sender: AnyObject, atCell: SelectionCell)
}


private let reuseIdentifier = "ReuseIdentifier"

class SelectionController: UICollectionViewController {

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
        
        let destroyMenuItem = UIMenuItem(title: "Destroy!", action: Selector(("performDestroy:")))
        let addMenuItem = UIMenuItem(title: "Add!", action: #selector(UIPushBehavior.addItem(_:)))
        UIMenuController.shared.menuItems = [addMenuItem, destroyMenuItem]
        
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
        
        // Configure the cell
        cell.delegate = self
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }

    // MARK: -
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {

        switch action.description {
            
        case "performDestroy:" :
            return true
            
        case "addItem:" :
            return true
            
        default :
            return false
        
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    }
    
}

extension SelectionController : CustomMenuDelegate {
    
    func performDestroy(_ sender: AnyObject, forCell: SelectionCell) {
        
        // Delete cell
        if let indexPath = collectionView?.indexPath(for: forCell) {
            dataArray.remove(at: indexPath.row)
            collectionView?.reloadData()
        }
        
    }
    
func addItem(_ sender: AnyObject, atCell: SelectionCell) {

    if let indexPath = collectionView?.indexPath(for: atCell) {
        dataArray.insert("NEW", at: indexPath.row)
        collectionView?.reloadData()
    }
    
}
}
