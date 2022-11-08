
import Foundation

class Flashcard_function {
    
    static func update_range(_ flashcard: inout Flashcard){
        if flashcard.range_txt == "" {
            return
        }
        var n1 = 0
        var n2 = 0
        var state = 0
        var res:[Int] = []
        for char in flashcard.range_txt {
            switch state {
            case 0:
                if char.isNumber {
                    n1 = char.wholeNumberValue ?? 0
                    state = 1
                } else {
                    return
                }
            case 1:
                if char.isNumber {
                    n1 = n1*10 + (char.wholeNumberValue ?? 0 )
                    state = 1
                } else if char == "," {
                    res.append(n1)
                    n1 = 0
                } else if char == "-" {
                    state = 2
                } else {
                    return
                }
            case 2:
                if char.isNumber {
                    n2 = char.wholeNumberValue ?? 0
                    state = 3
                } else {
                    return
                }
            case 3:
                if char.isNumber {
                    n2 = n2*10 + (char.wholeNumberValue ?? 0)
                    state = 3
                } else if char == "," {
                    for i in n1...n2 {
                        res.append(i)
                    }
                    n1 = 0
                    n2 = 0
                    state = 0
                } else {
                    return
                }
            default:
                print("wrong")
                return
            }
        }
        switch state {
        case 1:
            res.append(n1)
        case 3:
            for i in n1...n2 {
                res.append(i)
            }
        default:
            print("wrong")
            return
        }
        flashcard.range = res
        return
    }
    
    static func size(_ flashcard: Flashcard) -> Int{
        return flashcard.range.count
    }
    
    static func get_card(_ flashcard: Flashcard,_ ind: Int) -> Card{
        return flashcard.cards[flashcard.range[ind]]
    }
    
    static func get_random_card(_ flashcard: Flashcard) -> Card{
        let id:Int = Int.random(in:0..<(size(flashcard)))
        return flashcard.cards[flashcard.range[id]]
    }
}
