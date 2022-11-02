//
//  ContentView.swift
//  stupid app
//
//  Created by tuvshinzaya erdenekhuu on 22/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var game = Game()
    @State var flashcard = Flashcard()
    @State var back:Color = .white
    @State var text_color:Color = .black
    @State var state_app = "menu"
    @State var card_n = 0
    @State var cur_card = Card()
    @State var range_txt = ""
    @State var game_ins:Game_instance = Game_instance()
    
    func mod(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }
    
    func pressed(ind: Int){
        if !game_ins.guessed {
            if ind == game_ins.correct {
                back = .green
                game.score += 1
            } else {
                back = .red
                game.score = 0
            }
            game_ins.guessed = true
        }
    }
    
    func update_card() {
        cur_card = Flashcard_function.get_card(flashcard, card_n)
    }
    
    func start(){
        game.next_game(game_ins: &game_ins)
        back = .white
    }
    
    func start_memo() {
        card_n = 0
        state_app = "memo"
        update_card()
    }
    
    func start_game() {
        game = Game(cards: flashcard)
        game_ins = Game_instance()
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
                game_view (game_ins: $game_ins, go_menu: go_menu, pressed: pressed, start: start)
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

struct game_view: View {
    @Binding var game_ins: Game_instance
    let go_menu: () -> Void
    let pressed: (Int) -> Void
    let start: () -> Void
    
    var body: some View {
        Button(action: {go_menu()}){
            Text("Go to menu")
        }
        Spacer()
        Text(String(game_ins.score))
            .foregroundColor(.black)
        char_show_view(card: $game_ins.card)
        Spacer()
        HStack (spacing:100){
            Button(action: {pressed(0)}){
                Text(game_ins.options[0]).lineLimit(3)
            }
            .buttonStyle(BorderedButtonStyle())
            Button(action: {pressed(1)}){
                Text(game_ins.options[1]).lineLimit(3)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        HStack (spacing:100){
            Button(action: {pressed(2)}){
                Text(game_ins.options[2]).lineLimit(3)
            }
            .buttonStyle(BorderedButtonStyle())
            Button(action: {pressed(3)}){
                Text(game_ins.options[3]).lineLimit(3)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        Spacer()
        Button(action: {start()}){
            Text("Start")
        }
    }
}

struct memo_view: View {
    @Binding var cur_card: Card
    let go_menu: () -> Void
    let prev_card: () -> Void
    let next_card: () -> Void
    
    var body: some View {
        Button(action: {go_menu()}){
            Text("Go to menu")
        }
        Spacer()
            .buttonStyle(BorderedButtonStyle())
        char_show_view(card: $cur_card)
        Spacer()
            .frame(maxHeight: 10)
        Text(cur_card.meaning)
        Spacer()
        HStack() {
            Button(action: {prev_card()}){
                Text("Previous Character")
            }
            .buttonStyle(BorderedButtonStyle())
            Button(action: {next_card()}){
                Text("Next Character")
            }
            .buttonStyle(BorderedButtonStyle())
        }
        Spacer()
    }
}

struct menu_view: View{
    @Binding var range_txt: String
    @Binding var flashcard: Flashcard
    let set_range: () -> Void
    let start_memo: () -> Void
    let start_game: () -> Void
    
    var body: some View {
        Text("Current range \(flashcard.range_txt)")
        TextField("Range to use",text: $range_txt)
            .frame(width:250,height:30)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
        Button(action: {set_range()}) {
            Text("Set range")
        }
        .buttonStyle(BorderedButtonStyle())
        Button(action: {start_memo()}) {
            Text("Start memorizing")
        }
        .buttonStyle(BorderedButtonStyle())
        Button(action: {start_game()}) {
            Text("Start game")
        }
        .buttonStyle(BorderedButtonStyle())
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
