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

class GameSceneEditor: GameScene {
    
    let editingMode: EditingMode = .interact
    
    var selectedEntities: [GKEntity] = []
    
    var mouseDownEvent: MouseEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
    var mouseDragged: Bool = false
    
    
    override class var sceneName: String {
    
        return "GameSceneEditor"
    
    }
    
// MARK: Begin/End editing
    
    override func begin() {
    
        super.begin()
    
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
            
                game!.eventCenter.send(SpawnEvent(entity: MapObject(definition: MapObjectDefinition(spriteImageName: "grass.png", physicsMode: 2)), location: mouseEvent.location))
            
            } else {
            
                game!.eventCenter.send(SpawnEvent(entity: MapObject(definition: MapObjectDefinition(spriteImageName: "grass.png", physicsMode: 1)), location: mouseEvent.location))
            
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

}
