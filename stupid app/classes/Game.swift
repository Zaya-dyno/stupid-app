import Foundation

class Game{
    var cards:Flashcard = Flashcard()
    var score = 0
    
    init (){
    }
    
    init(cards:Flashcard) {
        self.cards = cards
    }
    
    func next_game(game_ins: inout Game_instance){
        game_ins.guessed = false
        var used:[Int] = []
        game_ins.card = Flashcard_function.get_random_card(cards)
        used.append(game_ins.card.id)
        var guesses:[Card] = []
        for _ in 1...3{
            var tmp = Flashcard_function.get_random_card(cards)
            while used.contains(tmp.id) {
                tmp = Flashcard_function.get_random_card(cards)
            }
            used.append(tmp.id)
            guesses.append(tmp)
        }
        game_ins.correct = Int.random(in: 0...3)
        game_ins.options.removeAll()
        for j in 0...3 {
            if j == game_ins.correct {
                game_ins.options.append(game_ins.card.meaning)
            } else {
                game_ins.options.append(guesses.first!.meaning)
                guesses.removeFirst()
            }
        }
        return
    }
}
