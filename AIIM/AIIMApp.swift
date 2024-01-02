// 
// AIIMApp.swift
// AIIM 
//
// Created by mkg on 1/1/24
//

import SwiftUI

@main
struct AIIMApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.checkForNewMessages()
        })
            
        // set initial message so LLM is not invoked on previous session message
        let initMessage = DatabaseManager.shared.getNewMessage()?.text ?? ""
        print("previous session message: \(initMessage)")
    }
                             
     func checkForNewMessages() {
        if let message = DatabaseManager.shared.getNewMessage() {
         Task {
             let oaiResponse = await LLM().openAICompletion(prompt: message.text)
             print("oaiResponse: \(oaiResponse)")
             DatabaseManager.shared.llmResponseToIgnore = oaiResponse
             
             // send the LLM response to the AppleID contact
             AppleScriptMessage().sendMessage(text: oaiResponse, appleId: Settings.appleId)
         }
         
        }
        
     }
}
