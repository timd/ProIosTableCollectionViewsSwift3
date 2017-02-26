//
//  ViewController.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let kCellIdentifier = "MVVMCell"
    
    var tableData = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: Data setup
    
    func setupData() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYmmDD"

        let dob1 = dateFormatter.date(from: "19280515")
        var character1 = Character(firstName: "Mickey", lastName: "Mouse")
        character1.dateOfBirth = dob1
        tableData.append(character1)

        let dob2 = dateFormatter.date(from: "19290317")
        var character2 = Character(firstName: "Minnie", lastName: "Mouse")
        character2.dateOfBirth = dob2
        tableData.append(character2)

        let dob3 = dateFormatter.date(from: "19371704")
        var character3 = Character(firstName: "Daffy", lastName: "Duck")
        character3.dateOfBirth = dob3
        tableData.append(character3)

        let dob4 = dateFormatter.date(from: "19400727")
        var character4 = Character(firstName: "Bugs", lastName: "Bunny")
        character4.dateOfBirth = dob4
        tableData.append(character4)

        let dob5 = dateFormatter.date(from: "19400302")
        var character5 = Character(firstName: "Elmer", lastName: "Fudd")
        character5.dateOfBirth = dob5
        tableData.append(character5)
        
        let dob6 = dateFormatter.date(from: "19320525")
        var character6 = Character(firstName: "Goofy", lastName: "")
        character6.dateOfBirth = dob6
        tableData.append(character6)
        
        let dob7 = dateFormatter.date(from: "19951122")
        var character7 = Character(firstName: "Buzz", lastName: "Lightyear")
        character7.dateOfBirth = dob7
        tableData.append(character7)
        
        let dob8 = dateFormatter.date(from: "20100709")
        var character8 = Character(firstName: "Felonius", lastName: "Gru")
        character8.dateOfBirth = dob8
        tableData.append(character8)

        let dob9 = dateFormatter.date(from: "20030530")
        var character9 = Character(firstName: "Nemo", lastName: "")
        character9.dateOfBirth = dob9
        tableData.append(character9)

        let dob10 = dateFormatter.date(from: "20100709")
        var character10 = Character(firstName: "Dave", lastName: "Minion")
        character10.dateOfBirth = dob10
        tableData.append(character10)
        
}
    
    
    // MARK: -
    // MARK: UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! MVVMCell
        
        let character = tableData[indexPath.row] as Character
        
        let characterViewModel = CharacterViewModel(character: character)
        
        cell.viewModel = characterViewModel
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

