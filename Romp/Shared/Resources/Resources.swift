//
//  Resources.swift
//  Romp
//
//  Created by Ryan Layne on 2/5/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Foundation

struct Resource {

    let name: String
    let texture: String
    let physics: PhysicsMode
    

}

typealias R = Resource

private var _resources: [Resource] = [

    R(name: "Grass", texture: "grass.png", physics: .fixed)

].sorted { (one, two) -> Bool in
    return one.name > two.name
}

extension Game {

    var resources: [Resource] {
    
        return _resources
    
    }

}
