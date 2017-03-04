//
//  ViewController.swift
//  CleanFooterTable
//
//  Created by Tim on 27/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let headerRect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0)
        let headerView = UIView(frame: headerRect)
        headerView.backgroundColor = UIColor.cyan
        tableView.tableHeaderView = headerView

        let footerRect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 75.0)
        let footerView = UIView(frame: footerRect)
        footerView.backgroundColor = UIColor.cyan
        tableView.tableFooterView = footerView
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
        
    }

    
}
