//
//  Background.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

class Background : GKEntity {

    init(imageNamed: String, tile: Bool) {
    
        super.init()
        
        let sprite = Sprite(texture: SKTexture(imageNamed: imageNamed));
        
        addComponent(sprite);
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
