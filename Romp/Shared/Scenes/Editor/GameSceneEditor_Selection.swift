//
//  GameEditorActions.swift
//  Romp
//
//  Created by Ryan Layne on 1/29/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

extension GameSceneEditor {

    // MARK: Selection
    
    func selectEntity(entity: GKEntity) {
    
        guard let sprite = entity.component(ofType: Sprite.self) else { return }
        
        if !selectedEntities.contains(entity) {
        
            selectedEntities.append(entity)
            selectionBoxes.append(SelectionBox(scene: self, node: sprite.node))
        
        }
        
        let ui = view?.subviews.first(where: { $0 is Editor }) as? Editor
        
        if let ui = ui {
        
            if selectedEntities.count == 1 {
            
                ui.setSelectedEntity(entity)
                
            } else {
            
                ui.setSelectedEntity(nil)
            
            }
            
        }
    
    }
    
    @discardableResult func selectEntity(_ at: CGPoint) -> GKEntity? {
    
        if let entity = getEntity(at) {
            
            selectEntity(entity: entity)
                        
            return entity
        
        }
        
        if let ui = view?.subviews.first(where: { $0 is Editor }) as? Editor {
                    
            if selectedEntities.count == 1 {
            
                ui.setSelectedEntity(selectedEntities.first)
                
            } else {
            
                ui.setSelectedEntity(nil)
            
            }
            
        }
        
        return nil
    
    }
    
    func isEntitySelected(_ entity: GKEntity) -> Bool {
    
        return selectedEntities.contains(entity)
    
    }
    
    func getEntity(_ at: CGPoint) -> GKEntity? {
    
        for component in game.componentSystems.editable.components {
        
            if let entity = component.entity {
            
                guard let sprite = entity.component(ofType: Sprite.self) else {
                    continue
                }
                
                if sprite.node.frame.contains(at) {
                
                    return entity
                
                }
            
            }
        
        }
        
        return nil
    
    }
    
    func moveSelectedEntities(from: CGPoint, to: CGPoint) {
    
        if selectedEntities.count > 0 {
            
            for entity in selectedEntities {
            
                guard let editable = entity.component(ofType: Editable.self) else {
                    continue
                }
                
                guard let sprite = entity.component(ofType: Sprite.self) else {
                    continue
                }
                
                let newPosition = CGPoint(
                    x: editable.dragStartPosition.x + (to.x - from.x),
                    y: editable.dragStartPosition.y + (to.y - from.y)
                )
                
                sprite.node.position = newPosition
            
            }
            
        }
        
        for selectionBox in selectionBoxes {
        
            selectionBox.redrawSelection()
        
        }
    
    }
    
    func deselectEntities(_ entities: [GKEntity]) {
    
        for entity in entities {
        
            selectedEntities.remove(at: selectedEntities.index(of: entity)!)
            
            for selectionBox in selectionBoxes {
            
                if selectionBox.node == entity.component(ofType: Sprite.self)!.node {
                
                    selectionBoxes.remove(at: selectionBoxes.index(of: selectionBox)!)
                    break
                
                }
            
            }
        
        }
    
    }
    
    func removeSelectedEntities() {
    
        for entity in selectedEntities {
            
            game.eventCenter.send(DestroyEvent(entity))
        
        }
    
    }
    
    
    // MARK: Resize
    
    func grabSelectionHandle(_ at: CGPoint) -> Bool {
    
        if selectionBoxes.count == 1 {
        
            if let selectionBox =  selectionBoxes.first {
            
                return selectionBox.grabHandle(at)
            
            }
        
        }
        
        return false
    
    }
    
    func moveSelectionHandle(_ at: CGPoint) -> Bool {
    
        for selectionBox in selectionBoxes {
        
            if selectionBox.moveHandle(at) {
            
                return true
            
            }
        
        }
        
        return false
    
    }
    
    func releaseSelectionHandle() {
    
        for selectionBox in selectionBoxes {
        
            selectionBox.releaseHandle()
        
        }
    
    }

}
