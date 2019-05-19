//
//  ViewController.swift
//  Podcast Consantrate
//
//  Created by Heshan Yodagama on 4/28/19.
//  Copyright © 2019 Heshan Yodagama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   private var randomNoForTheme:Int=0
   private let backgroundColor=[#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
   private let cardBackColor=[#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
    
    //meke kohomath private(set) daanna deyak naha...
    var numberOfPairOfCards:Int{
        //get eka witharak thiyenawanam "get" qla daanna oonama na
        return (cardButtons.count+1)/2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTheme()
        updateUIfromModel()
    }
    
    @IBOutlet private weak var updateLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    lazy var game = Consantration(numberOfPairOfCards: self.numberOfPairOfCards)
    
    
    @IBAction func selectedACard(_ sender: UIButton) {
        if  let cardNumber=cardButtons.firstIndex(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateUIfromModel()
        }else {print("this button is not in the list")
        }
    }
    
    private func updateUIfromModel() {
        
        for index in cardButtons.indices{
            let button=cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
            }else{
                button.backgroundColor=card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):cardBackColor[randomNoForTheme]
                button.setTitle("", for: UIControl.State.normal)
            }
        }
        scoreLabel.text="Score : "+String(game.score)
        updateLabel.text="Filps : "+String(game.flipCount)
        view.backgroundColor=backgroundColor[randomNoForTheme]
        
    }
   private var emojiChoises=[String]()
   private var emoji=[Int:String]()
    
   private func emoji(for card:Card)->String {
        
        //dictionary eke e identifire ekta imoji ekk(value ekk) nattm saha imojiChoise eke thawa imoji ithuruwela thiye nm
        if emoji[card.identifire]==nil , emojiChoises.count>0{
            let randomIndex=Int(arc4random_uniform(UInt32(emojiChoises.count)))
            //card eke identifire ekata eka emoji ekk RANDOMwa himi wenawaa
            emoji[card.identifire]=emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifire] ?? "?"
    }
    
    @IBAction func reset() {
        emoji.removeAll()
        changeTheme()
        game = Consantration(numberOfPairOfCards: (cardButtons.count+1)/2)
        updateUIfromModel()
        game.flipCount=0
        game.score=0
        game.identifireForPanalty.removeAll()
    }
    
   private func selectTheme() -> (emoji:[String],randomNo:Int) {
        var themes=Array<[String]>()
        let sport = ["🏊🏻‍","🏄🏻‍","🤽🏼‍","🚴🏻‍♀️","⛹🏻‍♀️","🚣🏻‍","🚵🏻‍","🤾🏻‍","🏊🏼‍","🚴🏻‍♂️","🚣🏼‍♂️","🤾🏼‍♂️",]
        themes.append(sport)
        let faces = ["😀","😍","😂","😇","😘","😛","😜","🥳","🥺","🤬","🥵","🥶","🤯","😱","🤮","🤐","🤖","🤡"]
        themes.append(faces)
        
        let animal = ["🦓","🦙","🦞","🐁","🐊","🐆","🐉","🐐","🐒","🐓","🐖","🐬","🐫","🐶","🐵","🦄","🦋"]
        themes.append(animal)
        let randomNo:Int = Int(arc4random_uniform(UInt32(themes.count)))
        return (themes[randomNo],randomNo)
    }
   private func changeTheme() {
        let theme=selectTheme()
        emojiChoises=theme.emoji
        randomNoForTheme=theme.randomNo
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!

}
