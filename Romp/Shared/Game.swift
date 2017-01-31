//
//  Game.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit
import SceneKit

struct CollisionCategory {

    static let inanimate: UInt32 = 1
    static let animate: UInt32 = 2

}

struct ComponentSystems {

    let editable = GKComponentSystem(componentClass: Editable.self)
    let sprite = GKComponentSystem(componentClass: Sprite.self)

}

class GameScenes {

    let game: GameScene
    
    init(_ game: Game) {
    
        self.game = GameScene.newScene(game)
    
    }

}

class Game {

    // View and scenes
    var view: SKView?
    var scenes: GameScenes?
    private var activeScene: SKScene?
    
    var entities: [GKEntity] = []
    private var state: GKStateMachine?
    
    let eventCenter = EventCenter()
    
    let componentSystems = ComponentSystems()
    
    init() {
        
        scenes = GameScenes(self)
        
        state = GKStateMachine(states: [
            GameStateMenu(self),
            GameStatePlaying(self),
            GameStateEditing(self),
            GameStateLoading(self),
            GameStatePaused(self)
        ])
        
    }
    
    func scene(_ scene: SKScene) {
    
        activeScene = scene
        view?.presentScene(scene)
    
    }
    
    func state(_ stateClass: Swift.AnyClass) {
    
        self.state?.enter(stateClass)
    
    }
    
    func spawn(entity: GKEntity, at: CGPoint) {
        
        // Add entity
        entities.append(entity)
        
        
        // Sprite node
        if let scene = self.activeScene {
        
            if let component = entity.component(ofType: Sprite.self) {
            
                component.node.position = at
                scene.addChild(component.node)
            
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
