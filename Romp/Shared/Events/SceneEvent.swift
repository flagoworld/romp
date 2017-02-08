//
//  StateEvent.swift
//  Romp
//
//  Created by Ryan Layne on 1/31/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class SceneEvent: Event {

    let sceneClass: Scene.Type
    
    init(_ sceneClass: Scene.Type) {
    
        self.sceneClass = sceneClass
    
    }

}
