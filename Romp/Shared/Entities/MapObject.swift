//
//  MapObject.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SceneKit
import GameplayKit

class MapObject: GKEntity {

    init(definition: MapObjectDefinition) {
    
        super.init()
        
        let texture = SKTexture(imageNamed: definition.spriteImageName)
        
        // Components
        let sprite = Sprite(texture: texture)
        let editable = Editable()
        
        addComponent(sprite)
        addComponent(editable)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
