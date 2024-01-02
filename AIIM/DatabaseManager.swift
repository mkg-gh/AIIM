// 
// DatabaseManager.swift
// AIIM 
//
// Created by mkg on 1/1/24
//

import Foundation
import SQLite

struct Message {
    var text: String
    var date: Int64
}

class DatabaseManager {
    private var db: Connection
    private let chatDatabasePath = "\(FileManager.default.homeDirectoryForCurrentUser)/Library/Messages/chat.db"
    private var latestMessage: Message?
    
    // ignore LLM responses as messages that need LLM completion
    var llmResponseToIgnore: String?
    
    static let shared = DatabaseManager()
    
    init() {
        db = try! Connection(chatDatabasePath, readonly: true)
    }
    
    func getNewMessage() -> Message? {
        do {
            guard let handle = try db.scalar("SELECT ROWID FROM handle WHERE service=\"iMessage\" AND id=\"\(Settings.appleId)\"") else {
                print("error: no contact id for handle")
                return nil
            }
            
            for row in try db.prepare("SELECT text, date FROM message WHERE handle_id=\(handle) AND text IS NOT NULL ORDER BY date DESC LIMIT 1;") {
                let message = Message(text: row[0] as! String, date: row[1] as! Int64)
                
                // set as latestMessage if it is not the previous LLM response
                if message.text != llmResponseToIgnore && message.date > latestMessage?.date ?? 0 {
                    latestMessage = message
                    return message
                }
            }

        } catch {
            print (error)
        }
        return nil
    }
}
