//
//  GameEditor.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

class GameSceneEditor: GameScene, EditorUIDelegate {
    
    var editingStateMachine: GKStateMachine?
    
    var selectedEntities: [GKEntity] = []
    var selectionBoxes: [SelectionBox] = []
    
    var mouseDownEvent: MouseEvent = MouseEvent(action: .down, buttons: [ .left ], modifiers: MouseEventModifiers(), location: CGPoint.zero)
    var mouseDragged: Bool = false
    
    // TODO: This will be resources or object definitions, loaded from a json file
    var resources: [Resource]?
    
    var activeResource: Resource? = nil
    
    override var uiClass: UserInterface.Type? {
    
        return Editor.self
    
    }
    
    required init(game: Game) {
        
        super.init(game: game)
        
        editingStateMachine = GKStateMachine(states: [
        
            EditorStateMap(eventCenter: game.eventCenter, editorScene: self),
            EditorStateObject(eventCenter: game.eventCenter, editorScene: self),
            EditorStateAdd(eventCenter: game.eventCenter, editorScene: self)
        
        ])
        
        editingStateMachine!.enter(EditorStateMap.self)

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


// MARK: Event handling

    override func handleEvent(_ event: Event) {
    
        super.handleEvent(event)
        
        if let destroyEvent = event as? DestroyEvent {
        
            for selectionBox in selectionBoxes {
            
                if selectionBox.node == destroyEvent.entity.component(ofType: Sprite.self)?.node {
                
                    selectionBoxes.remove(at: selectionBoxes.index(of: selectionBox)!)
                
                }
            
            }
            
            selectedEntities.remove(at: selectedEntities.index(of: destroyEvent.entity)!)
        
        }
    
    }
    
    
// MARK: Mouse input
    
    func mouseDownEvent(mouseEvent: MouseEvent) {
        
        mouseDownEvent = mouseEvent
        
    }
    
    func mouseDragEvent(mouseEvent: MouseEvent) {
    
        mouseDragged = true
        
    }
    
    func mouseUpEvent(mouseEvent: MouseEvent) {
    
        // Clear previous mouse info
        mouseDownEvent = MouseEvent(action: .down, buttons: .left, modifiers: MouseEventModifiers(), location: CGPoint.zero)
        mouseDragged = false
        
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
    
    func editorUIStateChanged(stateClass: GKState.Type) {
        
        editingStateMachine!.enter(stateClass)
        
    }
    
    func editorUIEditingTileChanged(tile: Bool) {
        
        self.selectedEntities.first!.component(ofType: Sprite.self)!.setRepeating(tile)
        
    }
    
    
    
    
    
    
    // todo: use KeyEvent
    
    override func keyDown(with event: NSEvent)
    {
        let s   =   event.charactersIgnoringModifiers!
        let s1  =   s.unicodeScalars
        let s2  =   s1[s1.startIndex].value
        let s3  =   Int(s2)
        
        if s3 == NSDeleteCharacter {
        
            removeSelectedEntities()
        
        }
    }

}
