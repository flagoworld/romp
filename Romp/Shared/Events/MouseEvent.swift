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

struct MouseEventButtons: OptionSet {

    let rawValue: Int
    
    static let left = MouseEventButtons(rawValue: 1 << 0)
    static let right = MouseEventButtons(rawValue: 1 << 1)
    static let middle = MouseEventButtons(rawValue: 1 << 2)

}

struct MouseEventModifiers: OptionSet {

    let rawValue: Int
    
    static let capsLock = MouseEventModifiers(rawValue: 1 << 0)
    static let shift = MouseEventModifiers(rawValue: 1 << 1)
    static let control = MouseEventModifiers(rawValue: 1 << 2)
    static let option = MouseEventModifiers(rawValue: 1 << 3)
    static let command = MouseEventModifiers(rawValue: 1 << 4)

}

class MouseEvent: Event {

    let action: MouseEventAction
    let buttons: MouseEventButtons
    let modifiers: MouseEventModifiers
    let location: CGPoint
    
    init(action: MouseEventAction, buttons: MouseEventButtons, modifiers: MouseEventModifiers, location: CGPoint) {
    
        self.action = action
        self.buttons = buttons
        self.modifiers = modifiers
        self.location = location
    
        super.init()
        
    }

}
