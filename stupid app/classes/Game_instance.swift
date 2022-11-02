import Foundation

struct Game_instance {
    var card:Card
    var options:[String] = []
    var correct:Int = 0
    var guessed = false
    var score = 0
    
    init(){
        options = ["Option 1", "Option 2", "Option 3", "Option 4"]
        card = Card()
        guessed = true
    }
    
    init(_ card:Card,_ options:[String],_ correct:Int,_ score: Int){
        guessed = false
        self.card = card
        self.options = options
        self.correct = correct
        self.score = score
    }
}
