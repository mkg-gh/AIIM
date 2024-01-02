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
    
    func openAICompletion(prompt: String) async -> String {
        let query = CompletionsQuery(model: .textDavinci_003, prompt: prompt, temperature: 0, maxTokens: 140, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
        do {
            let result = try await openAI.completions(query: query)
            let oaiResult = (result.choices.first?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            print("openai: \(oaiResult)")
            return oaiResult
        } catch {
            print("error: openai completion failure")
            return ""
        }
    }
}
