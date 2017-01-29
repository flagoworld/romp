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
    var physicsMode: String
    
    init(spriteImageName: String, physicsMode: String) {
    
        self.spriteImageName = spriteImageName
        self.physicsMode = physicsMode
    
    }
    
}
