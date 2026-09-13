import Foundation
import Observation

@Observable
class CardViewModel {
    let deck = Deck()
    var flashcard: Flashcard
    
    init() {
        self.flashcard = deck.drawRandomCard()
    }
    
    func drawNewCard() {
        self.flashcard = deck.drawRandomCard()
    }
}
//  CardViewModel.swift
//  RailsCards
//
//  Created by Apple on 13/09/2026.
//


