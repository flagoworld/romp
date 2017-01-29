//
//  Sprite.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class Sprite : GKComponent {

    let node: SKSpriteNode

    init(texture: SKTexture) {
    
        node = SKSpriteNode(texture: texture, size: texture.size());
        super.init()
        
        // TODO: Set up SKPhysicsBody
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
