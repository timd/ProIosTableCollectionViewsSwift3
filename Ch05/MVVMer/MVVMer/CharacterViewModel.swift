//
//  PersonViewModel.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

struct CharacterViewModel {
    
    var displayName: String
    var age: Int?
    
    init(character: Character) {
        
        displayName = character.firstName + " " + character.lastName
        
        if let dob = character.dateOfBirth {
            
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components(.year, from: dob as Date, to: Date(), options: [])
            age = components.year
            
        } else {
            
            age = nil
            
        }
        
    }
    
}
