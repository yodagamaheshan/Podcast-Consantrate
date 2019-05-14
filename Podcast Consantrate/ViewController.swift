//
//  ViewController.swift
//  Podcast Consantrate
//
//  Created by Heshan Yodagama on 4/28/19.
//  Copyright © 2019 Heshan Yodagama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Consantration(numberOfPairOfCards: (cardButtons.count+1)/2)
    
    
    var flipCount=0{
        didSet{
            updateLabel.text="Flips : \(flipCount)"
        }
    }
    
    @IBAction func selectedACard(_ sender: UIButton) {
        if  let cardNumber=cardButtons.firstIndex(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateUIfromModel()
        }else {print("this button is not in the list")
        }
        flipCount+=1
    }
    
    
    
    func updateUIfromModel() {
        for index in cardButtons.indices{
            let button=cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
            }else{
                button.backgroundColor=card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
                
            }
            
        }
    }
    
    var emojiChoises=["🤖","🤡", "👹", "👻", "🌺", "🍬", "🍷", "🍩" , "🍔"]
    var emoji=[Int:String]()
    
    func emoji(for card:Card)->String {
        if emoji[card.identifire]==nil , emojiChoises.count>0{
            let randomIndex=Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifire]=emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifire] ?? "?"
        
    }
    @IBAction func reset() {
    }
    
}
