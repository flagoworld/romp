//
//  MouseEvent.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Foundation

enum MouseEventAction {

    case down
    case drag
    case up

}

struct MouseEventModifiers: OptionSet {

    let rawValue: Int
    
    static let shift = MouseEventModifiers(rawValue: 1)
    static let control = MouseEventModifiers(rawValue: 2)
    static let command = MouseEventModifiers(rawValue: 3)
    static let option = MouseEventModifiers(rawValue: 4)

}

class MouseEvent: Event {

    let action: MouseEventAction
    let modifiers: MouseEventModifiers
    let location: CGPoint
    
    init(action: MouseEventAction, modifiers: MouseEventModifiers, location: CGPoint) {
    
        self.action = action
        self.modifiers = modifiers
        self.location = location
    
        super.init()
        
    }

}
