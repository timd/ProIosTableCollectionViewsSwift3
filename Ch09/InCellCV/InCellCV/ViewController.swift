//
//  ViewController.swift
//  InCellCV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var cvData = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func setupData() {
        for index in 0...100 {
            cvData.append(index)
        }
    }
    
    func addButtonToCell(_ cell: UICollectionViewCell) {
        
        guard cell.contentView.viewWithTag(1000) != nil else {
            return
        }
        
        let button = UIButton(type: UIButtonType.roundedRect)
        button.tag = 1000
        button.setTitle("Tap me!", for: UIControlState())
        button.sizeToFit()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.didTapButtonInCell(_:)), for: UIControlEvents.touchUpInside)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerX, relatedBy:
            NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)

        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -10)
        
        cell.contentView.addSubview(button)
        cell.contentView.addConstraints([vConstraint, hConstraint])
        
    }
    
    @objc func didTapButtonInCell(_ sender: UIButton) {
        
        let cell = sender.superview!.superview as! UICollectionViewCell
        let indexPathAtTap = collectionView.indexPath(for: cell)
        
        let alert = UIAlertController(title: "Something happened!", message: "A button was tapped in item \(indexPathAtTap!.row)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
        
        if let label = cell.contentView.viewWithTag(1000) as? UILabel {
            label.text = "Item \(cvData[indexPath.row])"
        }

        addButtonToCell(cell)
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        
        return cell
        
    }
}

