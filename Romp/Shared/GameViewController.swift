//
//  GameViewController.swift
//  Romp
//
//  Created by Ryan Layne on 2/1/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SceneKit
import GameplayKit

class GameViewController: ViewController, EventSubscriber {

    let game: Game = Game()
    let scenes: [ String: Scene ]
    
    required init?(coder: NSCoder) {
        
        scenes = [
        
            "\(GameSceneEditor.self)": GameSceneEditor.newScene(game: game)
        
        ]
        
        super.init(coder: coder)
        
        game.eventCenter.subscribe(self);
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        // Present the scene
        let skView = self.view as! SKView
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // For now, start up in editor mode
        game.eventCenter.send(SceneEvent(GameSceneEditor.self))
        
    }
    
    func handleEvent(_ event: Event) {
    
        if let sceneEvent = event as? SceneEvent {
        
            let skView = self.view as! SKView
            
            skView.presentScene(scenes["\(sceneEvent.sceneClass)"])
        
        }

    }

}
