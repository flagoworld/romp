//
//  GameEditor.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

enum EditingMode {

    // Selecting, dragging, etc
    case interact
    
    // Multiselect
    case select
    
    // Duplicate
    case duplicate
    
}

class GameSceneEditor: GameScene, EditorUIDelegate {
    
    let editingMode: EditingMode = .interact
    
    var selectedEntities: [GKEntity] = []
    
    var mouseDownEvent: MouseEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
    var mouseDragged: Bool = false
    
    var objectDefinitions: [AnyObject] = [ NSObject(), NSObject(), NSObject(), NSObject(), NSObject(), NSObject(), NSObject(), NSObject() ]
    var activeObjectDefinition: AnyObject? = nil
    
    override class var sceneName: String {
    
        return "GameSceneEditor"
    
    }
    
    override var uiClass: UserInterface.Type? {
    
        return Editor.self
    
    }
    
// MARK: Begin/End editing
    
    override func begin() {
    
        super.begin()
        
        if let ui = view?.subviews.first(where: { $0 is Editor }) as? Editor {
        
            ui.delegate = self
        
        }
    
    }
    
    override func end() {
    
        super.end()
    
    }
    
    
// MARK: Mouse input
    
    func mouseDownEvent(mouseEvent: MouseEvent) {
        
        mouseDownEvent = mouseEvent
        
        selectEntity(mouseEvent)
        
        if selectedEntities.count == 0 {
        
            if mouseEvent.modifiers.contains(.shift) {
            
                game!.eventCenter.send(SpawnEvent(entity: MapObject(imageNamed: "grass.png", physicsMode: .dynamic), location: mouseEvent.location))
            
            } else {
            
                game!.eventCenter.send(SpawnEvent(entity: MapObject(imageNamed: "grass.png", physicsMode: .fixed), location: mouseEvent.location))
            
            }
            
            selectEntity(mouseEvent)
        
        }
        
    }
    
    func mouseDragEvent(mouseEvent: MouseEvent) {
    
        mouseDragged = true
        
        moveSelectedEntities(mouseEvent)
        
    }
    
    func mouseUpEvent(mouseEvent: MouseEvent) {
    
        // Clear previous mouse info
        mouseDownEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
        mouseDragged = false
        
    }
    
    
    
// MARK: EventSubscriber
    
    override func handleEvent(_ event: Event) {
        
        super.handleEvent(event)
        
        switch event {
        
        case is MouseEvent:
            let mouseEvent = event as! MouseEvent
        
            switch mouseEvent.action {
            
            case .down:
                self.mouseDownEvent(mouseEvent: mouseEvent)
            
            case .drag:
                self.mouseDragEvent(mouseEvent: mouseEvent)
            
            case .up:
                self.mouseUpEvent(mouseEvent: mouseEvent)
            
            }
    
        default: break
        
        }
        
    }
    
    
// MARK: EditorUIDelegate

    func editorUIObjectDefinitions() -> [AnyObject] {
    
        return objectDefinitions
    
    }
    
    func editorUIActiveObjectDefinitionChanged(activeObjectDefinition: AnyObject?) {
    
        self.activeObjectDefinition = activeObjectDefinition
    
    }
    
    func editorUIActiveObjectDefinition() -> AnyObject? {
    
        return activeObjectDefinition
    
    }

}
