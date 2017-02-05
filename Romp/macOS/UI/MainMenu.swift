//
//  MainMenu.swift
//  Romp
//
//  Created by Ryan Layne on 2/2/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Cocoa

class MainMenu: UserInterface {
    
    @IBAction func startPressed(sender: AnyObject) {
    
        game!.eventCenter.send(SceneEvent(GameScene.self))
    
    }
    
    @IBAction func editorPressed(sender: AnyObject) {
    
        game!.eventCenter.send(SceneEvent(GameSceneEditor.self))
    
    }
    
    @IBAction func quitPressed(sender: AnyObject) {
    
        NSApp.terminate(self)
    
    }

}
