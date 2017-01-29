//
//  GameScene.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let game: Game = Game()
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    
    // Game on!
    
    func setUpScene() {
    
        
        game.scene = self
        
        // For now, start up in editor mode
        game.state?.enter(GameStateEditing.self)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        game.update(currentTime)
        
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            
        }
        
        for t in touches {
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
    
        let mouseEvent = MouseEvent(action: .down, modifiers: MouseEventModifiers(), location: event.location(in: self))
        game.eventCenter.send(mouseEvent)
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
        let mouseEvent = MouseEvent(action: .drag, modifiers: MouseEventModifiers(), location: event.location(in: self))
        game.eventCenter.send(mouseEvent)
        
    }
    
    override func mouseUp(with event: NSEvent) {
    
        let mouseEvent = MouseEvent(action: .up, modifiers: MouseEventModifiers(), location: event.location(in: self))
        game.eventCenter.send(mouseEvent)
        
    }

}
#endif

