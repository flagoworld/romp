//
//  EditorStateMap.swift
//  Romp
//
//  Created by Ryan Layne on 2/10/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import GameplayKit

class EditorStateObject: EditorState {

    var mouseDownEvent = MouseEvent(action: .down, buttons: [], modifiers: [], location: CGPoint.zero)

    override func mouseDownEvent(mouseEvent: MouseEvent) {
    
        guard let editorScene = self.editorScene else { return }
        
        mouseDownEvent = mouseEvent
        
        if mouseEvent.modifiers.contains(.shift) {
            
            if let entity = editorScene.getEntity(mouseEvent.location) {
                
                if editorScene.isEntitySelected(entity) {
                
                    editorScene.deselectEntities([entity])
                
                } else {
                
                    editorScene.selectEntity(entity: entity)
                
                }
            
            }
        
        } else {
        
            if !editorScene.grabSelectionHandle(mouseEvent.location) {
        
                let entity = editorScene.getEntity(mouseEvent.location)
                
                if entity == nil || !editorScene.isEntitySelected(entity!) {
                
                    editorScene.deselectEntities(editorScene.selectedEntities)
                    editorScene.selectEntity(mouseEvent.location)
                
                }
        
            }
        
        }
        
        super.mouseDownEvent(mouseEvent: mouseEvent)
    
    }
    
    override func mouseDragEvent(mouseEvent: MouseEvent) {
    
        guard let editorScene = self.editorScene else { return }
        
        if !editorScene.moveSelectionHandle(mouseEvent.location) {
        
            editorScene.moveSelectedEntities(from: mouseDownEvent.location, to: mouseEvent.location)
        
        }
        
    }
    
    override func mouseUpEvent(mouseEvent: MouseEvent) {
        
        guard let editorScene = self.editorScene else { return }
        
        editorScene.releaseSelectionHandle()
    
    }

}
