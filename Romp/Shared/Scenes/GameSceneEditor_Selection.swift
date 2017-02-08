//
//  GameEditorActions.swift
//  Romp
//
//  Created by Ryan Layne on 1/29/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

extension GameSceneEditor {

    func selectEntity(_ mouseEvent: MouseEvent) {
    
        deselectEntities()
        
        for component in game.componentSystems.editable.components {
        
            if let entity = component.entity {
            
                guard let editable = entity.component(ofType: Editable.self) else {
                    continue
                }
                
                guard let sprite = entity.component(ofType: Sprite.self) else {
                    continue
                }
                
                if sprite.node.frame.contains(mouseDownEvent.location) {
                
                    editable.dragStartPosition = sprite.node.position
                    selectedEntities.append(entity)
                    
                    break;
                
                }
            
            }
        
        }
        
        if let ui = view?.subviews.first(where: { $0 is Editor }) as? Editor {
        
            ui.setSelectedEntity(selectedEntities.first)
        
        }
        
        selectionBox.setSelectedNode(selectedEntities.first?.component(ofType: Sprite.self)?.node)
    
    }
    
    func moveSelectedEntities(_ mouseEvent: MouseEvent) {
    
        if selectedEntities.count > 0 {
            
            for entity in selectedEntities {
            
                guard let editable = entity.component(ofType: Editable.self) else {
                    continue
                }
                
                guard let sprite = entity.component(ofType: Sprite.self) else {
                    continue
                }
                
                let newPosition = CGPoint(
                    x: editable.dragStartPosition.x + (mouseEvent.location.x - mouseDownEvent.location.x),
                    y: editable.dragStartPosition.y + (mouseEvent.location.y - mouseDownEvent.location.y)
                )
                
                sprite.node.position = newPosition
            
            }
            
        }
        
        selectionBox.setSelectedNode(selectedEntities.first?.component(ofType: Sprite.self)?.node)
    
    }
    
    func deselectEntities() {
    
        selectedEntities.removeAll()
    
    }

}
