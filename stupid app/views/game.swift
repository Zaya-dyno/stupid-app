
import SwiftUI

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
            game_choices(game_ins: $game_ins, ind: 0, pressed: pressed)
            game_choices(game_ins: $game_ins, ind: 1, pressed: pressed)
        }
        HStack (spacing:100){
            game_choices(game_ins: $game_ins, ind: 2, pressed: pressed)
            game_choices(game_ins: $game_ins, ind: 3, pressed: pressed)
        }
        Spacer()
        Button(action: {start()}){
            Text("Start")
        }
    }
}

struct game_choices: View {
    @Binding var game_ins: Game_instance
    let ind: Int
    let pressed: (Int) -> Void
    
    var body: some View {
        Button(action: {pressed(ind)}){
            Text(game_ins.options[ind]).lineLimit(3)
        }
        .buttonStyle(BorderedButtonStyle())
    }
}
