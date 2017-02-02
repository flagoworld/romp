//
//  GameScene.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: Scene {
    
    override class var sceneName: String {
    
        return "GameScene"
    
    }
    
    override func begin() {
    
        super.begin()
    
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.80665)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.physicsBody?.categoryBitMask = CollisionCategory.inanimate
    
    }
    
    override func end() {
    
        super.end()
    
    }
    
}

