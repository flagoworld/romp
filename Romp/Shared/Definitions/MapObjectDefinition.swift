//
//  MapObjectDefinition.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Foundation

class MapObjectDefinition {

    var spriteImageName: String
    var physicsMode: UInt32
    
    init(spriteImageName: String, physicsMode: UInt32) {
    
        self.spriteImageName = spriteImageName
        self.physicsMode = physicsMode
    
    }
    
}
