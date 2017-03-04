//
//  ViewController.swift
//  NamesApp
//
//  Created by Tim on 25/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collation = UILocalizedIndexedCollation.current()
    var tableData: [String]!
    var sections: Array<Array<String>> = []
    //var sections: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parsePlist()
        
        configureSectionData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Name for the letter \(collation.sectionTitles[section])"
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return collation.sectionTitles
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let innerData = sections[indexPath.section]
        
        cell.textLabel!.text = innerData[indexPath.row]

        return cell
        
    }
    
    // MARK: -
    // MARK: Header and footer methods

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100.0)
        let headerView = UIView(frame: headerFrame)
        headerView.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.57, alpha: 1.0)
        
        let labelFrame = CGRect(x: 15.0, y: 80.0, width: view.frame.size.width, height: 15.0)
        let headerLabel = UILabel(frame: labelFrame)
        headerLabel.text = "Section Header"
        headerLabel.font = UIFont(name: "Courier-Bold", size: 18.0)
        headerLabel.textColor = UIColor.white

        headerView.addSubview(headerLabel)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0)
        let footerView = UIView(frame: footerFrame)
        footerView.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.57, alpha: 1.0)
        
        let labelFrame = CGRect(x: 15.0, y: 10.0, width: view.frame.size.width, height: 15.0)
        let footerLabel = UILabel(frame: labelFrame)
        footerLabel.text = "Section Footer"
        footerLabel.font = UIFont(name: "Times-New-Roman", size: 12.0)
        footerLabel.textColor = UIColor.blue
        
        footerView.addSubview(footerLabel)
        
        return footerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }

}

extension ViewController {
    
    func parsePlist() {
        let bundle = Bundle.main
        
        if let plistPath = bundle.path(forResource: "Names", ofType: "plist"),
            let namesDictionary = NSDictionary(contentsOfFile: plistPath),
            let names = namesDictionary["Names"] {
                tableData = names as! [String]
        }
    }
    
    func configureSectionData() {
        
        let selector: Selector = #selector(getter: NSString.lowercased)
        
        sections = Array(repeating: [], count: collation.sectionTitles.count)
        
        let sortedObjects = collation.sortedArray(from: tableData, collationStringSelector: selector)
        
        for object in sortedObjects {
            let sectionNumber = collation.section(for: object, collationStringSelector: selector)
            sections[sectionNumber].append(object as! String)
        }
        
    }

}
