# AIIM
iMessage LLMs 

---

Swift Mac App to listen for iMessages, prompt LLMs and send responses through Messages App using AppleScript.

---

## Setup
- Open project in Xcode
- Update Settings.swift with OpenAI key and AppleId you will send messages from
- Open Messages App on Mac. Works best with a different AppleId than the one set in Settings.swift. If they are they same then duplicate messages will be visible on each send.
- Compile and run project.
- When prompted, select 'Allow' for sending Apple Events to Messages
- Update Settings → Privacy & Security → Full Disk Access and toggle AIIM to On

## Supported:
- Tested on:
    - M1 Max Sonoma 14.2
    - M2 Pro 

## TODO:
- Settings UI to manage AppleID, keys, model selection
- llama.cpp integration for local LLM