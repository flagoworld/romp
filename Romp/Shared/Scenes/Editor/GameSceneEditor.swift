//
//  GameEditor.swift
//  Romp
//
//  Created by Ryan Layne on 1/28/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import GameplayKit

class GameSceneEditor: GameScene, EditorUIDelegate {
    
    var editingStateMachine: GKStateMachine?
    
    var selectedEntities: [GKEntity] = []
    var selectionBoxes: [SelectionBox] = []
    
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
        
        switch event {
        
        case let destroyEvent as DestroyEvent:
            for selectionBox in selectionBoxes {
            
                if selectionBox.node == destroyEvent.entity.component(ofType: Sprite.self)?.node {
                
                    selectionBoxes.remove(at: selectionBoxes.index(of: selectionBox)!)
                
                }
            
            }
            
            selectedEntities.remove(at: selectedEntities.index(of: destroyEvent.entity)!)
        
        case let keyEvent as KeyEvent:
            
            // TODO: Wrap NSDeleteCharacter since it's only present in macOS
            if keyEvent.keyCode == UnicodeScalar(NSDeleteCharacter) {
            
                removeSelectedEntities()
            
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
    
    func editorUIStateChanged(stateClass: GKState.Type) {
        
        editingStateMachine!.enter(stateClass)
        
    }
    
    func editorUIEditingTileChanged(tile: Bool) {
        
        self.selectedEntities.first!.component(ofType: Sprite.self)!.setRepeating(tile)
        
    }

}
