//
//  GameEditor.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

enum EditingMode {

    case edit
    case add
    
}

class GameSceneEditor: GameScene, EditorUIDelegate {
    
    var editingMode: EditingMode = .edit
    
    var selectedEntities: [GKEntity] = []
    let selectionBox: SelectionBox = SelectionBox()
    
    var mouseDownEvent: MouseEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
    var mouseDragged: Bool = false
    
    // TODO: This will be resources or object definitions, loaded from a json file
    var resources: [Resource]?
    
    var activeResource: Resource? = nil
    
    override var uiClass: UserInterface.Type? {
    
        return Editor.self
    
    }
    
    required init(game: Game) {
        
        super.init(game: game)
        
        selectionBox.addToScene(self)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Begin/End editing
    
    override func begin() {
    
        super.begin()
        
        resources = game.resources
        
        if let ui = view?.subviews.first(where: { $0 is Editor }) as? Editor {
        
            ui.delegate = self
            ui.setSelectedEntity(selectedEntities.first)
        
        }
    
    }
    
    override func end() {
    
        super.end()
    
    }
    
    
// MARK: Mouse input
    
    func mouseDownEvent(mouseEvent: MouseEvent) {
        
        mouseDownEvent = mouseEvent
        
        
        if !selectionBox.grabHandle(mouseEvent.location) {
        
            selectEntity(mouseEvent)
            
            if selectedEntities.count == 0 && editingMode == .add {
            
                if let activeResource = self.activeResource {
                
                    game.eventCenter.send(SpawnEvent(entity: MapObject(activeResource), location: mouseEvent.location))
                    
                }
                
                selectEntity(mouseEvent)
            
            }
            
        }
        
    }
    
    func mouseDragEvent(mouseEvent: MouseEvent) {
    
        mouseDragged = true
        
        if !selectionBox.moveHandle(mouseEvent.location) {
        
            moveSelectedEntities(mouseEvent)
            
        }
        
    }
    
    func mouseUpEvent(mouseEvent: MouseEvent) {
    
        // Clear previous mouse info
        mouseDownEvent = MouseEvent(action: .down, button: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
        mouseDragged = false
        selectionBox.releaseHandle()
        
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

    func editorUIResources() -> [Resource] {
    
        return resources!
    
    }
    
    func editorUIActiveResourceChanged(activeResource: Resource?) {
    
        self.activeResource = activeResource
    
    }
    
    func editorUIActiveResource() -> Resource? {
    
        return activeResource
    
    }
    
    func editorUIEditingModeChanged(editingMode: EditingMode) {
        
        self.editingMode = editingMode
        
    }

}
