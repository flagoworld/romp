//
//  Scene.swift
//  Romp
//
//  Created by Ryan Layne on 1/30/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene, EventSubscriber {

    var ui: UserInterface? = nil
    var game: Game
    
    var uiClass: UserInterface.Type? {
    
        return nil
    
    }
    
    required init(game: Game) {
    
        self.game = game
        
        super.init(size: CGSize(width: 1, height: 1))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        fatalError("cannot load scene from nib")
        
    }
    
    deinit {
    
        end()
    
    }
    
    override func didMove(to view: SKView) {
    
        
        loadUI()
        
        backgroundColor = NSColor.black
        
        begin()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    
        game.update(currentTime)
        
    }
    
    
    func loadUI() {
    
        view!.subviews.first(where: { $0 is UserInterface })?.removeFromSuperview()
        
        if uiClass != nil {
        
            let ui = uiClass!.loadUI(game)
            ui.frame = view!.bounds
            
            self.ui = ui
            
            view!.addSubview(ui)
            
        }
    
    }
    
    
    // MARK: Scene methods
    
    func begin() {
    
        game.eventCenter.subscribe(self)
        
        view!.autoresizesSubviews = true
    
    }
    
    
    func end() {
    
        game.eventCenter.unsubscribe(self)
    
    }
    
    func handleEvent(_ event: Event) {
    
        switch event {
        
        case let spawnEvent as SpawnEvent:
            if let component = spawnEvent.entity.component(ofType: Sprite.self) {
            
                component.node.position = spawnEvent.location
                addChild(component.node)
            
            }
        
        case let destroyEvent as DestroyEvent:
            if let component = destroyEvent.entity.component(ofType: Sprite.self) {
            
                component.node.removeFromParent()
            
            }
        
        default: break;
        
        }
    
    }

}


#if os(OSX)
// Mouse events
extension Scene {

    override var acceptsFirstResponder: Bool { return true }

    override open func mouseDown(with event: NSEvent) {
    
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .down, buttons: button, modifiers: modifiers, location: event.location(in: self.scene!))
        
        game.eventCenter.send(mouseEvent)
        
        self.view?.window?.makeFirstResponder(self)
        
    }
    
    override open func mouseDragged(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .drag, buttons: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game.eventCenter.send(mouseEvent)
        
    }
    
    override open func mouseUp(with event: NSEvent) {
        
        let button = mouseButton(NSEvent.pressedMouseButtons())
        let modifiers = mouseModifiers(NSEvent.modifierFlags())
        let mouseEvent = MouseEvent(action: .up, buttons: button, modifiers: modifiers, location: event.location(in: self.scene!))
        game.eventCenter.send(mouseEvent)
        
    }
    
    func mouseButton(_ pressedMouseButtons: Int) -> MouseEventButtons {

        var buttons = MouseEventButtons()
        
        if (pressedMouseButtons & (1 << 0)) != 0 {
        
            buttons.insert(.left)
        
        }
        
        if (pressedMouseButtons & (1 << 1)) != 0 {
        
            buttons.insert(.right)
        
        }
        
        if (pressedMouseButtons & (1 << 2)) != 0 {
        
            buttons.insert(.middle)
        
        }
        
        return buttons

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
    
    override func keyDown(with event: NSEvent) {
    
        let chars   =   event.charactersIgnoringModifiers!
        let scalars  =   chars.unicodeScalars
    
        game.eventCenter.send(KeyEvent(scalars[scalars.startIndex]))
    
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
