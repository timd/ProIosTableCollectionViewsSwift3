//
//  ViewController.swift
//  InCellTV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableData = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupData()

        refreshControl?.addTarget(self, action: #selector(TableViewController.didPullRefresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupData() {
        for index in 0...5 {
            tableData.append(index)
        }
    }
    
    @objc func didPullRefresh(_ sender: UIRefreshControl) {
        
        tableData.append(tableData.count)
        tableView.reloadData()
        
        sender.endRefreshing()
        
    }

    @objc func didTapButtonInCell(_ sender: UIButton) {
        
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
        button.addTarget(self, action: #selector(TableViewController.didTapButtonInCell(_:)), for: UIControlEvents.touchUpInside)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerY, relatedBy:
            NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
        
        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -20)
        
        cell.contentView.addSubview(button)
        cell.contentView.addConstraints([vConstraint, hConstraint])

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = "Row \(tableData[indexPath.row])"

        addButtonToCell(cell)
        
        return cell
    }
    
}

