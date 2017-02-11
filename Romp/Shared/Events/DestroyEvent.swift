//
//  DestroyEvent.swift
//  Romp
//
//  Created by Ryan Layne on 2/11/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class DestroyEvent: Event {

    let entity: GKEntity
    
    init(_ entity: GKEntity) {
    
        self.entity = entity
    
    }

}
