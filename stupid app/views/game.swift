
import Foundation

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
