//
//  Consantrate.swift
//  Podcast Consantrate
//
//  Created by Heshan Yodagama on 5/10/19.
//  Copyright © 2019 Heshan Yodagama. All rights reserved.
//

import Foundation
class Consantration{
    
   private(set) var cards=[Card]()
   private var  indexOfOneAndOnlyFaceUpCards:Int?{
        //face up card ekk vitarak(only) tiyenm eke agaya return..nttn nil
        get{
            //mekedi default value eka nill nisa(optional vala)index ekk dunne nattn return krddi nil return wenne
            var foundIndex:Int?
            for index in cards.indices{
                //card is face up
                if cards[index].isFaceUp{
                    //there were no other face up card yet
                    if foundIndex==nil{
                        foundIndex=index
                    }else{
                        foundIndex=nil
                    }
                }
            }
            return foundIndex
        }set{
            //dena card value eka face up krla anith ewwa face down krnwaa
            for index in cards.indices{
                cards[index].isFaceUp=(index==newValue)
            }
        }
    }
    var score = 0
    var identifireForPanalty=[Int:Int]()
    var flipCount=0
    private var date:Date?
    
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
            }
                //when one card choose or 3rd card choose
            else{
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
    
   private func  insertForPanalty(identifire:Int) {
        //if whelue exist
        if let clickedValue=identifireForPanalty[identifire]{
            identifireForPanalty[identifire]=clickedValue+1
        }
        else{
            identifireForPanalty[identifire]=1
        }
    }
    
   private  func checkPanalty(for matchIndex:Int,and Index:Int){
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
