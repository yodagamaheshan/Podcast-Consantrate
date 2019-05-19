//
//  Card.swift
//  Podcast Consantrate
//
//  Created by Heshan Yodagama on 5/10/19.
//  Copyright © 2019 Heshan Yodagama. All rights reserved.
//

import Foundation
struct Card {
    
    var isFaceUp=false
    var isMatched = false
    var involvedInAmismatch = false
    var identifire:Int
    //here we dont put emoji cause these models are UI independent so we dont put them
   private static var identifireFactory=0
    
   private static func getUniqueIdentifire()->Int{
         identifireFactory += 1
        return identifireFactory
    }
    
    init() {
        identifire=Card.getUniqueIdentifire()
    }
    
}

