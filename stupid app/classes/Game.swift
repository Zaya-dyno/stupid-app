import Foundation

class Game{
    var cards:Flashcard = Flashcard()
    var possible:[Int] = []
    
    init (){
    }
    
    init(cards:Flashcard) {
        self.cards = cards
        self.possible = cards.range
    }
    
    func next_game(game_ins: inout Game_instance){
        if possible.count <= 0 {
            game_ins.card.sound = "Guessed every card"
            return
        }
        let cor_id = Int.random(in:0..<possible.count)
        game_ins.card = cards.cards[possible[cor_id]]
        var used:[Int] = [possible[cor_id]]
        possible.remove(at: cor_id)
        game_ins.guessed = false
        var guesses:[Card] = []
        while guesses.count < 3 {
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
