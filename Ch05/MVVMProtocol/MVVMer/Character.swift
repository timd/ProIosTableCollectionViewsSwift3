//
//  Person.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

protocol CharacterViewModel {
    var displayName: String {get}
    var age: Int? {get}
}

struct Character : CharacterViewModel {
    
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    
    init(firstName: String = "", lastName: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = nil
    }
    
}

extension Character {
    
    var displayName: String {
        return firstName + " " + lastName
    }
    
    var age: Int? {
        
        if let dateOfBirth = self.dateOfBirth {
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components(.year, from: dateOfBirth, to: Date(), options: [])
            return components.year
        }
        
        return nil
        
    }
    
}
