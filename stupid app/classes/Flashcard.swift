//
//  flashcard.swift
//  stupid app
//
//  Created by tuvshinzaya erdenekhuu on 22/10/2022.
//

import Foundation

struct Flashcard {
    var cards :[Card] = [];
    var index = 0
    var range_txt = ""
    var range:[Int] = []
    
    init () {
        let db = database()
        cards = db.read_card_from_db()
        index = 0
        range_txt = "0-" + String(cards.count - 1)
        for i in 0..<cards.count {
            range.append(i)
        }
    }
    
    init (cards: [Card]){
        index = 0
        range_txt = "0-" + String(cards.count - 1)
        for i in 0..<cards.count {
            range.append(i)
        }
    }
}
