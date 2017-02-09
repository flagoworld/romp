//
//  Resources.swift
//  Romp
//
//  Created by Ryan Layne on 2/5/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Foundation

class Resource {

    let name: String
    let texture: String
    let physics: PhysicsMode
    let tile: Bool
    
    init(name: String, texture: String, physics: PhysicsMode, tile: Bool) {
    
        self.name = name
        self.texture = texture
        self.physics = physics
        self.tile = tile
    
    }

}

typealias R = Resource

private var _resources: [Resource] = [

    R(name: "Grass", texture: "grass.png", physics: .fixed, tile: true)

].sorted { (one, two) -> Bool in
    return one.name > two.name
}

extension Game {

    var resources: [Resource] {
    
        return _resources
    
    }

}
