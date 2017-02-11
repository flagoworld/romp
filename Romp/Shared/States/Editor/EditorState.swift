//
//  EditorStateMap.swift
//  Romp
//
//  Created by Ryan Layne on 2/10/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import GameplayKit

class EditorState: GKState, EventSubscriber {

    let eventCenter: EventCenter
    weak var editorScene: GameSceneEditor?

    required init(eventCenter: EventCenter, editorScene: GameSceneEditor) {
        
        self.eventCenter = eventCenter
        self.editorScene = editorScene
        
        super.init()
        
    }

    override func didEnter(from previousState: GKState?) {
    
        eventCenter.subscribe(self)

    }
    
    override func willExit(to nextState: GKState) {
    
        eventCenter.unsubscribe(self)

    }
    
    func handleEvent(_ event: Event) {
        
        switch event {
        
        case let mouseEvent as MouseEvent:
        
            switch mouseEvent.action {
            
            case .down:
                mouseDownEvent(mouseEvent: mouseEvent)
            
            case .drag:
                mouseDragEvent(mouseEvent: mouseEvent)
            
            case .up:
                mouseUpEvent(mouseEvent: mouseEvent)
            
            }
    
        default: break
        
        }
        
    }
    
    func mouseDownEvent(mouseEvent: MouseEvent) {
    
        // Override
        
        guard let editorScene = self.editorScene else { return }
        
        for entity in editorScene.selectedEntities {
        
            guard let editable = entity.component(ofType: Editable.self) else { continue }
            guard let sprite = entity.component(ofType: Sprite.self) else { continue }
            
            editable.dragStartPosition = sprite.node.position
        
        }
    
    }
    
    func mouseDragEvent(mouseEvent: MouseEvent) {
    
        // Override
    
    }
    
    func mouseUpEvent(mouseEvent: MouseEvent) {
    
        // Override
    
    }

}
