//
//  KeyEvent.swift
//  Romp
//
//  Created by Ryan Layne on 2/12/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import Foundation

class KeyEvent: Event {

    let keyCode: UnicodeScalar
    
    init(_ keyCode: UnicodeScalar) {
    
        self.keyCode = keyCode
    
    }

}
