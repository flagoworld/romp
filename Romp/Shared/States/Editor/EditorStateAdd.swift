//
//  EditorStateMap.swift
//  Romp
//
//  Created by Ryan Layne on 2/10/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

class EditorStateAdd: EditorState {

    var mouseDownEvent = MouseEvent(action: .down, buttons: [], modifiers: [], location: CGPoint.zero)

    override func mouseDownEvent(mouseEvent: MouseEvent) {
    
        guard let editorScene = self.editorScene else { return }
        
        mouseDownEvent = mouseEvent
        
        if !editorScene.grabSelectionHandle(mouseEvent.location) {
        
            editorScene.deselectEntities(editorScene.selectedEntities)
    
            if editorScene.selectEntity(mouseEvent.location) == nil {
                
                if let activeResource = editorScene.activeResource {
                
                    eventCenter.send(SpawnEvent(entity: MapObject(activeResource), location: mouseEvent.location))
                    
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
