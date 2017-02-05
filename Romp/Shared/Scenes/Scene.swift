//
//  Scene.swift
//  Romp
//
//  Created by Ryan Layne on 1/30/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene, EventSubscriber {

    private var isLoaded = false
    
    var ui: UserInterface? = nil
    var game: Game?
    
    var uiClass: UserInterface.Type? {
    
        return nil
    
    }
    
    init(game: Game) {
    
        super.init(size: CGSize(width: 1, height: 1))
    
        self.game = game
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        
    }
    
    override func didMove(to view: SKView) {
    
        
        if !isLoaded {
        
            isLoaded = true
            load()
        
        }
        
        begin()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        
        
    }
    
    
    func loadUI() {
    
        view!.subviews.first(where: { $0 is UserInterface })?.removeFromSuperview()
        
        if uiClass != nil {
        
            let ui = uiClass!.loadUI(game!)
            ui.frame = view!.bounds
            
            self.ui = ui
            
            view!.addSubview(ui)
            
        }
    
    }
    
    
    // MARK: Scene methods
    
    func load() {
    
        loadUI();
        
        backgroundColor = NSColor.white
    
    }
    
    
    func begin() {
    
        game!.eventCenter.subscribe(self)
        
        view!.autoresizesSubviews = true
    
    }
    
    
    func end() {
    
        game!.eventCenter.unsubscribe(self)
    
    }
    
    func handleEvent(_ event: Event) {
    
        if let spawnEvent = event as? SpawnEvent {
        
            if let component = spawnEvent.entity.component(ofType: Sprite.self) {
            
                component.node.position = spawnEvent.location
                addChild(component.node)
            
            }
        
        }
    
    }

}


#if os(OSX)
// Mouse events
extension Scene {

    override open func mouseDown(with event: NSEvent) {
    
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .down, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        
        game!.eventCenter.send(mouseEvent)
        
    }
    
    override open func mouseDragged(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .drag, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game!.eventCenter.send(mouseEvent)
        
    }
    
    override open func mouseUp(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .up, button: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game!.eventCenter.send(mouseEvent)
        
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
