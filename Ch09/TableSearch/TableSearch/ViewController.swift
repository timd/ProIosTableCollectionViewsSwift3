//
//  ViewController.swift
//  TableSearch
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    var tableData = [String]()
    var filteredTableData = [String]()
    
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController {

    func setupData() {
        
        if let results = arrayFromContentsOfFileWithName("spatowns") {
            tableData = results
        }
        
    }
    
    func arrayFromContentsOfFileWithName(_ fileName: String) -> [String]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: ",\n")
        } catch _ as NSError {
            return nil
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return filteredTableData.count
        }
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        if searchActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
        } else {
            cell.textLabel!.text = tableData[indexPath.row]
        }
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        searchBar.autocapitalizationType = .none
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0 {
            searchActive = false
            tableView.reloadData()
            return
        }
        
        searchActive = true
        
        filteredTableData = tableData.filter({( spaTown: String) -> Bool in
            
            let stringMatch = spaTown.lowercased().range(of: searchText.lowercased())
            
            return stringMatch != nil
            
        })
        
        tableView.reloadData()
        
    }
    
}
