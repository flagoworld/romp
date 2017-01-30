//
//  Game.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

struct CollisionCategory {

    static let inanimate: UInt32 = 1
    static let animate: UInt32 = 2

}

struct ComponentSystems {

    let editable = GKComponentSystem(componentClass: Editable.self)
    let sprite = GKComponentSystem(componentClass: Sprite.self)

}

import GameplayKit

class Game {
    var scene: SKScene?
    var entities: [GKEntity] = []
    var state: GKStateMachine?
    var editor: GameEditor?
    
    let eventCenter = EventCenter()
    
    let componentSystems = ComponentSystems()
    
    init() {
        
        state = GKStateMachine(states: [
            GameStateMenu(self),
            GameStatePlaying(self),
            GameStateEditing(self),
            GameStateLoading(self),
            GameStatePaused(self)
        ])
        
        editor = GameEditor(self)
        
    }
    
    func spawn(entity: GKEntity, at: CGPoint) {
        
        // Add entity
        entities.append(entity)
        
        
        // Sprite node
        if let scene = self.scene {
        
            if let component = entity.component(ofType: Sprite.self) {
            
                scene.addChild(component.node)
                component.node.position = at
            
            }
        
        }
        
        
        // Add components to systems
        componentSystems.editable.addComponent(foundIn: entity);
        componentSystems.sprite.addComponent(foundIn: entity);
    }
    
    func update(_ currentTime: TimeInterval) {
    
        componentSystems.sprite.update(deltaTime: currentTime)
        
    }
}
