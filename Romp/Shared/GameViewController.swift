//
//  GameViewController.swift
//  Romp
//
//  Created by Ryan Layne on 2/1/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameViewController: ViewController, EventSubscriber {

    let game: Game = Game()
    
    required init?(coder: NSCoder) {
        
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
        game.eventCenter.send(SceneEvent(MainMenuScene.self))
        
    }
    
    func handleEvent(_ event: Event) {
    
        if let sceneEvent = event as? SceneEvent {
        
            self.view.nextResponder = self
            
            let skView = self.view as! SKView
            
            let scene = sceneEvent.sceneClass.init(game: game)
            
            scene.size = CGSize(width: 1366.0, height: 1024.0)
            scene.scaleMode = .aspectFill;
            
            skView.presentScene(scene)
        
        }

    }

}
