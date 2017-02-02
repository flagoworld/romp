//
//  StateEvent.swift
//  Romp
//
//  Created by Ryan Layne on 1/31/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SceneKit
import GameplayKit

class SceneEvent: Event {

    let sceneClass: SKScene.Type
    
    init(_ sceneClass: SKScene.Type) {
    
        self.sceneClass = sceneClass
    
    }

}
