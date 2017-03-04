//
//  ViewController.swift
//  Bounce
//
//  Created by Tim Duckett on 03/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var cvData = [String]()
    
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

extension ViewController {

    func setupData() {
        
        for index in 0...0 {
            cvData.append("\(index)")
        }
        
    }
    
    func setupCollectionView() {
        
        let layout = BounceLayout()
        layout.itemSize = CGSize(width: 75,height: 75)
        layout.sidePadding = 10
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func didTapAdd(_ sender: AnyObject) {

        // Get index of last item
        let index = cvData.count
        
        cvData.append("\(index)")

        // Create an NSIndexPath object for the new item
        let newItemIndexPath = IndexPath(item: index, section: 0)

        // Now update the collection view
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.collectionView.insertItems(at: [newItemIndexPath])
            
            }) { (finished) -> Void in
                
            // code
        }
        

    }

    @IBAction func didTapRemoveItem(_ sender: AnyObject) {
        
        let itemIndex = cvData.count - 1
        
        removeItemAtIndexPath(IndexPath(item: itemIndex, section: 0))
    }

    func removeItemAtIndexPath(_ indexPath: IndexPath) {
        
        // Don't attempt to remove the last item!
        if cvData.count == 0 {
            return
        }
        
        // Remove it from the data array
        cvData.remove(at: indexPath.row)
        
        // Now update the collection view
        collectionView.deleteItems(at: [indexPath])

    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath)

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = "Cell \(indexPath.row)"
        cellLabel.textColor = UIColor.white
        
        cell.contentView.layer.borderColor = UIColor.cyan.cgColor
        cell.contentView.backgroundColor = UIColor.black
        cell.contentView.layer.borderWidth = 3.0
        
        return cell
        
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            didTapAdd(indexPath as AnyObject)
            
        default:
            removeItemAtIndexPath(indexPath)
        }
        
    }
    
}
