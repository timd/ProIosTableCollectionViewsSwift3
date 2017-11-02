//
//  TableViewController.swift
//  TableView
//
//  Created by Tim on 18/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var tableData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add edit button to the nav bar
        let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TableViewController.didTapEditButton))

        self.navigationItem.leftBarButtonItem = editButton
        
        // Setup table
        tableView.register(UINib(nibName: "TableCustomCell", bundle: nil), forCellReuseIdentifier: "MyCustomCell")
        
        tableData = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "Sieben", "Acht", "Neun", "Zehn", "Elf", "Zwolf", "Dreizehn", "Vierzehn", "Fünfzehn"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath)

        let text: String  = tableData[indexPath.row]
        
        // Configure the cell...
        if let textLabel = cell.contentView.viewWithTag(1000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        if let textLabel = cell.contentView.viewWithTag(2000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        if let textLabel = cell.contentView.viewWithTag(3000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // calculate height of row here
        return 50
    }
    
    // Override to support conditional editing of the table voverride iew.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {

            tableData.append("New item")
            tableView.reloadData()
            
        }
    }

    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let contentViewSize = cell?.contentView.frame.size.width
        
        print("size = \((contentViewSize.debugDescription))")
        
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {

        let rowToMove = tableData[fromIndexPath.row]
        tableData.remove(at: fromIndexPath.row)
        tableData.insert(rowToMove, at: toIndexPath.row)
        tableView.reloadData()
        
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

}

extension TableViewController {
    
    @IBAction func didTapEditButton() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
}
