//
//  MapObject.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PhysicsMode {

    case none
    case fixed
    case dynamic

}

class MapObject: GKEntity {

    let resource: Resource

    init(_ resource: Resource) {
    
        self.resource = resource
    
        super.init()
        
        let texture = SKTexture(imageNamed: resource.texture)
        
        // Components
        let sprite = Sprite(texture: texture)
        let editable = Editable()
        
        switch resource.physics {
        
        case .none:
            break
        
        case .fixed:
            sprite.node.physicsBody = SKPhysicsBody(rectangleOf: sprite.node.size)
            sprite.node.physicsBody!.isDynamic = false
        
        case .dynamic:
            sprite.node.physicsBody = SKPhysicsBody(rectangleOf: sprite.node.size)
        
        }
        
        addComponent(sprite)
        addComponent(editable)
        
        sprite.setRepeating(true)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
