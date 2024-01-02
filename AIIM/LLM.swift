// 
// LLM.swift
// AIIM 
//
// Created by mkg on 1/1/24
//

import Foundation
import OpenAI

class LLM {
    
    private var openAI = OpenAI(apiToken: Settings.oaiAuthToken)
    
    func gptChat(prompt: String) async -> String {
        let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: .user, content: prompt)])
        do {
            let result = try await openAI.chats(query: query)
            let oaiResult = (result.choices.first?.message.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            print("openai: \(oaiResult)")
            return oaiResult
        } catch {
            print("error: openai chat failure")
            return ""
        }
        
    }
}
