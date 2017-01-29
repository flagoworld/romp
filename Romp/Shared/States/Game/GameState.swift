//
//  GameState.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

class GameState: GKState {
    
    let game: Game
    
    init(_ game: Game) {
    
        self.game = game
        super.init()
        
    }
    
}
