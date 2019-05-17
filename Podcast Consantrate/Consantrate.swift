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
    var score = 0
    var  identifireForPanalty=[Int:Int]()
    var flipCount=0
    var date:Date?
    
    func chooseCard(at index:Int) {
       
        
        flipCount+=1
        if !cards[index].isMatched{
            //if 2nd another card choosed
            if let matchIndex=indexOfOneAndOnlyFaceUpCards , matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifire == cards[index].identifire {
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                    score+=2
                    score+=abs(Int(5/date!.timeIntervalSinceNow))
                }
                else{
                    insertForPanalty(identifire: cards[index].identifire)
                    checkPanalty(for: cards[matchIndex].identifire, and: cards[index].identifire )
                }
                cards[index].isFaceUp=true
                indexOfOneAndOnlyFaceUpCards=nil
                //when another one card cheese
            }
                //when one card choose or 3rd card choose
            else{
               
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp=false
                }
                cards[index].isFaceUp=true
                insertForPanalty(identifire: cards[index].identifire)
                indexOfOneAndOnlyFaceUpCards=index
                 date=Date()
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
    
    func  insertForPanalty(identifire:Int) {
        //if whelue exist
        if let clickedValue=identifireForPanalty[identifire]{
            identifireForPanalty[identifire]=clickedValue+1
        }
        else{
            identifireForPanalty[identifire]=1
        }
    }
    
    func checkPanalty(for matchIndex:Int,and Index:Int){
        //check for before one
        if identifireForPanalty[matchIndex]!>1{
            score-=1
        }
        //check last clicked one
        if identifireForPanalty[Index]!>1{
            score-=1
        }
    }
    
}
