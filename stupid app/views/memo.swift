import SwiftUI

struct memo_view: View {
    @Binding var flashcard: Flashcard
    @Binding var card_n: Int
    let go_menu: () -> Void
    @Binding var cur_card: Card
    
    func update_card() {
        cur_card = Flashcard_function.get_card(flashcard, card_n)
    }
    
    func mod(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
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
    
    var body: some View {
        Button(action: {go_menu()}){
            Text("Go to menu")
        }
        Spacer()
            .buttonStyle(BorderedButtonStyle())
        Text(String(cur_card.id))
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
