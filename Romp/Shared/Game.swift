//
//  Game.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit
import SpriteKit

struct CollisionCategory {

    static let inanimate: UInt32 = 1
    static let animate: UInt32 = 2

}

struct ComponentSystems {

    let editable = GKComponentSystem(componentClass: Editable.self)
    let sprite = GKComponentSystem(componentClass: Sprite.self)

}

class Game: EventSubscriber {

    let eventCenter = EventCenter()
    
    var entities: [GKEntity] = []
    let componentSystems = ComponentSystems()
    
    init() {
        
        eventCenter.subscribe(self)
        
    }
    
    func update(_ currentTime: TimeInterval) {
    
        componentSystems.sprite.update(deltaTime: currentTime)
        
    }
    
    func handleEvent(_ event: Event) {
    
        if let spawnEvent = event as? SpawnEvent {
        
            entities.append(spawnEvent.entity)
            
            componentSystems.editable.addComponent(foundIn: spawnEvent.entity)
            componentSystems.sprite.addComponent(foundIn: spawnEvent.entity)
        
        }
    
    }
}
