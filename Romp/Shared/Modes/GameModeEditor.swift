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

class GameModeEditor: GameMode, EventSubscriber {

    let game: Game
    
    let editingMode: EditingMode = .interact
    
    var selectedEntities: [GKEntity] = []
    
    var mouseDownEvent: MouseEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
    var mouseDragged: Bool = false
    
    init(_ game: Game) {
    
        self.game = game
        
    }
    
    
// MARK: Begin/End editing
    
    override func begin() {
    
        game.eventCenter.subscribe(self)
    
    }
    
    override func end() {
    
        game.eventCenter.unsubscribe(self)
    
    }
    
    
// MARK: Mouse input
    
    func mouseDown(mouseEvent: MouseEvent) {
        
        mouseDownEvent = mouseEvent
        
        selectEntity(mouseEvent)
        
        if selectedEntities.count == 0 {
        
            if mouseEvent.modifiers.contains(.shift) {
            
                game.spawn(entity: MapObject(definition: MapObjectDefinition(spriteImageName: "grass.png", physicsMode: 2)), at:mouseEvent.location)
            
            } else {
            
                game.spawn(entity: MapObject(definition: MapObjectDefinition(spriteImageName: "grass.png", physicsMode: 1)), at:mouseEvent.location)
            
            }
            
            selectEntity(mouseEvent)
        
        }
        
    }
    
    func mouseDrag(mouseEvent: MouseEvent) {
    
        mouseDragged = true
        
        moveSelectedEntities(mouseEvent)
        
    }
    
    func mouseUp(mouseEvent: MouseEvent) {
    
        // Clear previous mouse info
        mouseDownEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
        mouseDragged = false
        
    }
    
    
    
// MARK: EventSubscriber
    
    func handleEvent(_ event: Event) {
        
        switch event {
        
            case is MouseEvent:
                let mouseEvent = event as! MouseEvent
            
                switch mouseEvent.action {
                
                    case .down:
                        self.mouseDown(mouseEvent: mouseEvent)
                    
                    case .drag:
                        self.mouseDrag(mouseEvent: mouseEvent)
                    
                    case .up:
                        self.mouseUp(mouseEvent: mouseEvent)
                
                }
        
            default: break
        
        }
        
    }

}
