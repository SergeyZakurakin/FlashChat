//
//  Message.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 28/06/2024.
//

import Foundation

struct Message {
    
    enum Sender {
        case me
        case you
    }
    
    let sender: Sender
    let body: String
}

extension Message {
    static func getMessages() -> [Message] {
        
        return [
            Message(sender: .you, body: "Hey! How are you today? :)"),
            Message(sender: .me, body: "Hi! I'm doing great, thanks! :) How about you?"),
            Message(sender: .you, body: "I'm good too, thanks for asking! Any exciting plans for the weekends?"),
            Message(sender: .me, body: "Actually, yes! I'm going on the hiking trip with some friends."),
            Message(sender: .you, body: "We're going to explore a national park nearby. How about you?"),
            Message(sender: .me, body: "Sounds amazing! I'm planning to catch up on some reading and maybe go for a bike ride"),
            Message(sender: .you, body: "That sounds relaxing. Enjoy your time"),
            Message(sender: .me, body: "Thank you! Have a fantastic hiking trip, and let's catch up soon"),
            Message(sender: .you, body: "Absolutely! Take care and talk to you later")
        
        ]
        
    }
}
