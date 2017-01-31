//
//  Scene.swift
//  Romp
//
//  Created by Ryan Layne on 1/30/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene {

    var game: Game?
    
    class func newScene(_ game: Game) -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        
        let sceneName = self.sceneName()
        
        guard let scene = SKScene(fileNamed: sceneName) as? GameScene else {
            print("Failed to load \(sceneName).sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        scene.game = game
        
        return scene
    }
    
    class func sceneName() -> String {
    
        return "Noname"
    
    }
    
    override func didMove(to view: SKView) {
    
        self.setUpScene()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        game?.update(currentTime)
        
    }
    
    func setUpScene() {
    
        // Override
    
    }

}


#if os(OSX)
// Mouse events
extension Scene {

    override open func mouseDown(with event: NSEvent) {
    
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .down, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        
        game?.eventCenter.send(mouseEvent)
        
    }
    
    override open func mouseDragged(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .drag, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game?.eventCenter.send(mouseEvent)
        
    }
    
    override open func mouseUp(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .up, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game?.eventCenter.send(mouseEvent)
        
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

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension Scene {

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
