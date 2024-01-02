// 
// AppleScriptMessage.swift
// AIIM 
//
// Created by mkg on 1/1/24
//

import Foundation

struct AppleScriptMessage {
    func sendMessage(text: String, appleId: String) {
        let appleScript = """
        on run argv
            tell application "Messages"
                set targetContact to "\(appleId)"
                set targetService to id of 1st account whose service type = iMessage
                set textMessage to "\(text)"
                set contact to participant targetContact of account id targetService
                send textMessage to contact
            end tell
        end run
        """
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: appleScript) {
            if let outputString = scriptObject.executeAndReturnError(&error).stringValue {
                print(outputString)
            } else if (error != nil) {
                print("error: ", error!)
            }
        }
    }
}
