import SwiftUI

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
