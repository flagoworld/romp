//
//  SpawnEvent.swift
//  Romp
//
//  Created by Ryan Layne on 1/31/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpawnEvent: Event {

    let entity: GKEntity
    let location: CGPoint
    
    init(entity: GKEntity, location: CGPoint) {
    
        self.entity = entity
        self.location = location
    
    }

}
