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
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.80665);
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
        
        self.physicsBody?.categoryBitMask = CollisionCategory.inanimate
        
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
    
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .down, button: button, modifiers: modifiers, location: event.location(in: self))
        
        game.eventCenter.send(mouseEvent)
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .drag, button: button, modifiers: modifiers, location: event.location(in: self))
        game.eventCenter.send(mouseEvent)
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .up, button: button, modifiers: modifiers, location: event.location(in: self))
        game.eventCenter.send(mouseEvent)
        
    }
    
    func mouseButton(_ pressedMouseButtons: Int) -> MouseEventButton {

        if (pressedMouseButtons & (1 << 0)) > 0 {
        
            return .left
        
        }
        
        if (pressedMouseButtons & (1 << 1)) > 0 {
        
            return .right
        
        }
        
        if (pressedMouseButtons & (1 << 2)) > 0 {
        
            return .middle
        
        }
        
        return .left

    }

    func mouseModifiers(_ modifierFlags: NSEventModifierFlags) -> MouseEventModifiers {
    
        var modifiers = MouseEventModifiers()
        
        if modifierFlags.contains(.capsLock) {
            
            modifiers.insert(MouseEventModifiers.capsLock)
            
        }
        
        if modifierFlags.contains(.shift) {
            
            modifiers.insert(MouseEventModifiers.shift)
            
        }
        
        if modifierFlags.contains(.control) {
            
            modifiers.insert(MouseEventModifiers.control)
            
        }
        
        if modifierFlags.contains(.option) {
            
            modifiers.insert(MouseEventModifiers.option)
            
        }
        
        if modifierFlags.contains(.command) {
            
            modifiers.insert(MouseEventModifiers.command)
            
        }
        
        return modifiers
    
    }

}

#endif

