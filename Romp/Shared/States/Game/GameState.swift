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
    private(set) var gameMode: GameMode?
    
    init(_ game: Game) {
    
        self.game = game
        
        super.init()
        
    }
    
    func beginGameMode(_ gameMode: GameMode) {
    
        self.gameMode = gameMode
        gameMode.begin()
    
    }
    
    func endGameMode() {
    
        if let gameMode = self.gameMode {
        
            gameMode.end()
        
        }
    
    }
    
}
