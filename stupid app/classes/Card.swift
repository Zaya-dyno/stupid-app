
import Foundation

struct Card {
    var id:Int = 0
    var char:String = ""
    var sound:String = ""
    var meaning:String = ""
    
    init(){
        id = -1
        char = "玩"
        sound = ""
        meaning = ""
    }
    
    init(_ pars:[String]){
        char = pars[1]
        sound = pars[2]
        meaning = pars[3]
        self.id = Int(pars[0])!
    }
}
