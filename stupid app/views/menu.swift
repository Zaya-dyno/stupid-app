import Foundation

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
