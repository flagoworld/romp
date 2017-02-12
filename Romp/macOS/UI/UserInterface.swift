//
//  UserInterface.swift
//  Romp
//
//  Created by Ryan Layne on 2/3/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import Cocoa

class UserInterface: NSView {

    var game: Game? = nil
    
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
    }

    class func loadUI(_ game: Game) -> UserInterface {
    
        var topLevelObjects: NSArray = []
        
        if !Bundle.main.loadNibNamed("\(self)", owner: nil, topLevelObjects: &topLevelObjects) {
        
            fatalError("Could not load nib for class: \(self)")
        
        }
        
        if topLevelObjects.count == 0 {
        
            fatalError("No top level objects found in nib")
        
        }
        
        let view = topLevelObjects.first(where: { $0 is UserInterface }) as! UserInterface
        
        view.game = game
        view.autoresizingMask = [ .viewWidthSizable, .viewHeightSizable ]
        
        return view
    
    }

}
