//
//  ViewController.swift
//  InCellTV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var tableData = [Int]()
    

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupData()
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ViewController.didPullRefresh(_:)), for: .valueChanged)
    tableView.addSubview(refreshControl)
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {

    func setupData() {
        for index in 0...5 {
            tableData.append(index)
        }
    }
    
    func didPullRefresh(_ sender: UIRefreshControl) {
        
        tableData.append(tableData.count)
        tableView.reloadData()
        
        sender.endRefreshing()
        
    }

    func didTapButtonInCell(_ sender: UIButton) {
        
        let cell = sender.superview!.superview as! UITableViewCell
        let indexPathAtTap = tableView.indexPath(for: cell)
        
        let alert = UIAlertController(title: "Something happened!", message: "A button was tapped at row \(indexPathAtTap!.row)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
        
    func addButtonToCell(_ cell: UITableViewCell) {
        
        guard cell.viewWithTag(1000) == nil else {
            return
        }
        
        let button = UIButton(type: UIButtonType.roundedRect)
        button.tag = 1000
        button.setTitle("Tap me!", for: UIControlState())
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.didTapButtonInCell(_:)), for: UIControlEvents.touchUpInside)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerY, relatedBy:
            NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
        
        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -20)
        
        cell.contentView.addSubview(button)
        cell.contentView.addConstraints([vConstraint, hConstraint])

    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = "Row \(tableData[indexPath.row])"

        addButtonToCell(cell)
        
        return cell
    }
    
}

