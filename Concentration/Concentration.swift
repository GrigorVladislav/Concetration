//
//  Concentration.swift
//  Lecture 2 - Concentration
//
//  Created by Michel Deiman on 13/11/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    } else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index==newValue)
            }
            
        }
    }
	
	func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentrarion.chooseCards(at: \(index)): chosen index not in the cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
            
			} else {
            
				indexOfOneAndOnlyFaceUpCard = index
			}
			
		}
	}
	
	init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards>0, "Concentrarion.chooseCards(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
            
		}
        cards=Shufflee(Cards: cards)

	}
    
   
    func Shufflee(Cards:[Card])->[Card]{
        var newCards = Cards
        for i in newCards.indices{
            
            let randomIndex = Int(arc4random_uniform(UInt32(newCards.count-1)))
            (newCards[i],newCards[randomIndex])=(newCards[randomIndex],newCards[i])
            
        }
        return newCards
    }
	
}
