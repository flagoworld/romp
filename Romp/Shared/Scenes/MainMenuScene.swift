//
//  MainMenuScene.swift
//  Romp
//
//  Created by Ryan Layne on 2/3/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: Scene {

    override class var sceneName: String {
    
        return "MainMenuScene"
    
    }
    
    override var uiClass: UserInterface.Type? {
    
        return MainMenu.self
    
    }
    
}
