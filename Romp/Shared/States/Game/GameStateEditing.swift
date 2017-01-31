//
//  GameStateEditing.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

class GameStateEditing: GameState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    
        return true
        
    }
    
    override func didEnter(from previousState: GKState?) {
        
        game.scene(game.scenes!.game)
        beginGameMode(GameModeEditor(game))
        
    }
    
    override func willExit(to nextState: GKState) {
        
        endGameMode()
        
    }

}
