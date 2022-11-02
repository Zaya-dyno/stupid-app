//
//  database.swift
//  stupid app
//
//  Created by tuvshinzaya erdenekhuu on 24/10/2022.
//

import Foundation
import SQLite3

class database {
    
    var db: OpaquePointer?
    
    init (){
        db = openDatabase("hsk1")
    }
    
    func sent_command_nodata(_ command:String?) {
        guard let command = command else {
            print("command is nil")
            return
        }
      // 1
      var commandStatement: OpaquePointer?
      // 2
      if sqlite3_prepare_v2(db, command, -1, &commandStatement, nil) ==
          SQLITE_OK {
        // 3
        if sqlite3_step(commandStatement) == SQLITE_DONE {
          print("\nCommand succeeded.")
        } else {
          print("\nCommand failed.")
        }
      } else {
        print("\nSucceeded.")
      }
      // 4
      sqlite3_finalize(commandStatement)
    }
    
    func read_card_from_db() -> [Card] {
        let command = "SELECT * FROM characters"
        var cards:[Card] = []
        // 1
        var commandStatement: OpaquePointer?
        // 2
        if sqlite3_prepare_v2(db, command, -1, &commandStatement, nil) == SQLITE_OK {
        // 3
            while(sqlite3_step(commandStatement) == SQLITE_ROW) {
                var card = Card()
                let id = sqlite3_column_int64(commandStatement, 0)
                card.id = Int(id)

                if let cString = sqlite3_column_text(commandStatement, 1) {
                    card.char = String(cString: cString)
                }
                if let cString = sqlite3_column_text(commandStatement, 2) {
                    card.sound = String(cString: cString)
                }
                if let cString = sqlite3_column_text(commandStatement, 3) {
                    card.meaning = String(cString: cString)
                }
                cards.append(card)
            }
        }
        // 4
        sqlite3_finalize(commandStatement)
        return cards
    }
    
    func openDatabase(_ part1DbPath:String?) -> OpaquePointer? {
      var db: OpaquePointer?
      guard let part1DbPath = Bundle.main.path(forResource: part1DbPath, ofType: "sql") else {
        print("part1DbPath is nil.")
        return nil
      }
      if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
        print("Successfully opened connection to database at \(part1DbPath)")
        return db
      } else {
        print("Unable to open database.")
        return nil
      }
    }
}
