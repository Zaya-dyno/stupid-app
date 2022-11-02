//
//  ContentView.swift
//  stupid app
//
//  Created by tuvshinzaya erdenekhuu on 22/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var flashcard = Flashcard()
    @State var back:Color = .white
    @State var text_color:Color = .black
    @State var state_app = "menu"
    @State var card_n = 0
    @State var cur_card = Card()
    @State var range_txt = ""
    @State var game_ins:Game_instance = Game_instance()
    @State var game = Game()
    
    func mod(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }
    
    func update_card() {
        cur_card = Flashcard_function.get_card(flashcard, card_n)
    }
    
    func start_memo() {
        card_n = 0
        state_app = "memo"
        update_card()
    }
    
    func start_game() {
        game = Game(cards: flashcard)
        game_ins = Game_instance()
        game.next_game(game_ins: &game_ins)
        state_app = "game"
    }
    
    func set_range() {
        flashcard.range_txt = range_txt
        Flashcard_function.update_range(&flashcard)
    }
    
    func next_card() {
        card_n += 1
        card_n = mod(card_n,Flashcard_function.size(flashcard))
        update_card()
    }
    
    func prev_card() {
        card_n -= 1
        card_n = mod(card_n,Flashcard_function.size(flashcard))
        update_card()
    }
    
    func go_menu(){
        back = .white
        state_app = "menu"
    }
    
    var body: some View {
        VStack{
            if state_app == "menu" {
                menu_view(range_txt:$range_txt,flashcard: $flashcard, set_range:set_range,start_memo: start_memo,start_game:start_game)
            } else if state_app == "game" {
                game_view(game_ins: game_ins, game: game, go_menu: go_menu)
            } else if state_app == "memo" {
                memo_view(cur_card: $cur_card, go_menu: go_menu, prev_card: prev_card, next_card: next_card)
            }
        
        }
        .padding()
        .frame(minWidth:0,maxWidth: .infinity,minHeight:0,maxHeight: .infinity,alignment: .center)
        .background(back)
        .accentColor(text_color)
        .foregroundColor(text_color)
    }
}

struct char_show_view: View {
    @Binding var card: Card
    
    func decide_char_size() -> CGFloat {
        switch card.char.count {
        case 1:
            return 100
        case 2:
            return 80
        case 3:
            return 60
        default:
            return 50
        }
    }

    var body: some View {
        Text(card.char)
            .frame(width: 300, height: 300)
            .font(.custom("Body",size:decide_char_size()))
            .foregroundColor(.black)
        Text(card.sound)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
