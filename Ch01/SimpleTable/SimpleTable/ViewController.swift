//
//  ViewController.swift
//  SimpleTable
//
//  Created by Tim on 10/01/16.
//  Copyright © 2016 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for count in 0...10 {
            // The cell will contain the string "Item X"
            tableData.append("Item \(count)")
        }
        
        // Print out the contents of the data array into the log
        print("The tableData array contains \(tableData)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:
    //MARK: UITableViewDatasource functions    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        cell.textLabel!	.text = tableData[indexPath.row]
        
        return cell
        
    }
    
    // MARK:
    // MARK: UITableViewDelegate functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let messageString = "You tapped row \(indexPath.row)"
            
            let alertController = UIAlertController(title: "Row tapped", message: messageString, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default,  handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                print("\(messageString)")
            }
            
    }

    
}

