//
//  Consantrate.swift
//  Podcast Consantrate
//
//  Created by Heshan Yodagama on 5/10/19.
//  Copyright © 2019 Heshan Yodagama. All rights reserved.
//

import Foundation
class Consantration{
    var cards=[Card]()
    var  indexOfOneAndOnlyFaceUpCards:Int?
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched{
            if let matchIndex=indexOfOneAndOnlyFaceUpCards , matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifire == cards[index].identifire {
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                }
                cards[index].isFaceUp=true
                indexOfOneAndOnlyFaceUpCards=nil
            }else{
                //either no cards or 2 cards r face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp=false
                }
                cards[index].isFaceUp=true
                indexOfOneAndOnlyFaceUpCards=index
            }
        }
    }
    init(numberOfPairOfCards:Int) {
        for _ in 1...numberOfPairOfCards{
            let card=Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
}
