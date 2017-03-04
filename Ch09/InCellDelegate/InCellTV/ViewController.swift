//
//  ViewController.swift
//  InCellTV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

protocol InCellButtonProtocol {
    func didTapButtonInCell(_ cell: ButtonCell)
}

class ViewController: UIViewController, InCellButtonProtocol {
    
    @IBOutlet var tableView: UITableView!
    var tableData = [Int]()

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
        for index in 0...125 {
            tableData.append(index)
        }
    }

    func didTapButtonInCell(_ cell: ButtonCell) {
        
        let indexPathAtTap = tableView.indexPath(for: cell)
        
        let alert = UIAlertController(title: "Something happened!", message: "A button was tapped at row \(indexPathAtTap!.row)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! ButtonCell
        cell.textLabel?.text = "Row \(tableData[indexPath.row])"

        if cell.delegate == nil {
            cell.delegate = self
        }
        
        return cell
    }
    
}

