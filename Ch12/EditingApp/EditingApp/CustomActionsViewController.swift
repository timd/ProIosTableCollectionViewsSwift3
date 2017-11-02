//
//  CustomActionsViewController.swift
//  EditingApp
//
//  Created by Tim on 01/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomActionsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CustomActionsViewController {
    
    func setupData() {
        for index in 0...50 {
            tableData.append("\(index)")
        }
    }
    
}

extension CustomActionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let tweet = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Tweet") { action, index in
        print("selected tweet action")
        tableView.setEditing(false, animated: true)
    }
    
    tweet.backgroundColor = UIColor.lightGray

    let facebook = UITableViewRowAction(style: .normal, title: "Facebook") { action, index in
        print("selected facebook action")
        tableView.setEditing(false, animated: true)
    }
    
    facebook.backgroundColor = UIColor.blue
    
    let email = UITableViewRowAction(style: .normal, title: "Email") { action, index in
        print("selected email action")
        tableView.setEditing(false, animated: true)
    }
    
    email.backgroundColor = UIColor.purple
    
    return [tweet, facebook, email]
    
}
    
}

extension CustomActionsViewController: UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel!.text = "Row \(tableData[indexPath.row])"
        return cell
    }
    
}

