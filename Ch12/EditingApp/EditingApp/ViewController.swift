//
//  ViewController.swift
//  EditingApp
//
//  Created by Tim on 01/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Row insertion"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        for index in 0...10 {
            tableData.append("Row \(index)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        if indexPath.row == tableData.count {
            cell.textLabel?.text = "Add new row"
            cell.textLabel?.textColor = UIColor.darkGray
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
        }

        return cell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if (indexPath.row == tableData.count) {
        
        // put table into edit mode
        tableView.setEditing(true, animated: true)
        
    } else {
        
        // Handle "normal" selection
        
    }
    
}
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if tableView.isEditing {
            if (indexPath.row == tableData.count) {
                return UITableViewCellEditingStyle.insert;
            } else {
                return UITableViewCellEditingStyle.delete;
            }
        }
        
        return UITableViewCellEditingStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        } else if (editingStyle == UITableViewCellEditingStyle.insert) {
            
            let thingToInsert = "\(Date())"
            tableData.append(thingToInsert)
            tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        if (indexPath.row == tableData.count) {
    return false
        }

        return true
        
    }
    
func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        tableData.insert(tableData[sourceIndexPath.row], at: destinationIndexPath.row)
        tableData.remove(at: sourceIndexPath.row + 1)
    
            
}
    
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
                if proposedDestinationIndexPath.row == tableData.count {
                return sourceIndexPath
                }
                
                return proposedDestinationIndexPath
    }
    
    
}
