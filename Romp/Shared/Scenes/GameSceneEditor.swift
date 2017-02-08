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

class SelectionBox {

    let topLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let topRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let outline = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    
    init() {
    
        topLeftHandle.fillColor = NSColor.clear
        topLeftHandle.strokeColor = NSColor.red
        topLeftHandle.lineWidth = 1
        topLeftHandle.zPosition = 2
        
        topRightHandle.fillColor = NSColor.clear
        topRightHandle.strokeColor = NSColor.red
        topRightHandle.lineWidth = 1
        topRightHandle.zPosition = 2
        
        bottomRightHandle.fillColor = NSColor.clear
        bottomRightHandle.strokeColor = NSColor.red
        bottomRightHandle.lineWidth = 1
        bottomRightHandle.zPosition = 2
        
        bottomLeftHandle.fillColor = NSColor.clear
        bottomLeftHandle.strokeColor = NSColor.red
        bottomLeftHandle.lineWidth = 1
        bottomLeftHandle.zPosition = 2
        
        outline.fillColor = NSColor.clear
        outline.strokeColor = NSColor.red
        outline.lineWidth = 1
        outline.zPosition = 1
    
    }
    
    func setSelectedNode(_ node: SKNode?) {
    
        if let node = node {
        
            topLeftHandle.position = node.position
            topRightHandle.position = CGPoint(x: node.frame.origin.x + node.frame.size.width - topRightHandle.frame.size.width, y: node.frame.origin.y)
            bottomRightHandle.position = CGPoint(x: node.frame.origin.x + node.frame.size.width - topRightHandle.frame.size.width, y: node.frame.origin.y + node.frame.size.height - bottomRightHandle.frame.size.height)
            bottomLeftHandle.position = CGPoint(x: node.frame.origin.x, y: node.frame.origin.y + node.frame.size.height - bottomRightHandle.frame.size.height)
            
            outline.position = CGPoint(x: node.position.x - 1, y: node.position.y - 1)
            outline.xScale = node.xScale + 2
            outline.yScale = node.yScale + 2
            
            setHidden(false)
        
        } else {
        
            setHidden(true)
        
        }
    
    }
    
    func setHidden(_ hidden: Bool) {
    
        topLeftHandle.isHidden = hidden
        topRightHandle.isHidden = hidden
        bottomRightHandle.isHidden = hidden
        bottomLeftHandle.isHidden = hidden
        outline.isHidden = hidden
    
    }
    
    func addToScene(_ scene: SKScene) {
    
        scene.addChild(topLeftHandle)
        scene.addChild(topRightHandle)
        scene.addChild(bottomRightHandle)
        scene.addChild(bottomLeftHandle)
        scene.addChild(outline)
    
    }

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
        
        selectEntity(mouseEvent)
        
        if selectedEntities.count == 0 && editingMode == .add {
        
            if let activeResource = self.activeResource {
            
                game.eventCenter.send(SpawnEvent(entity: MapObject(activeResource), location: mouseEvent.location))
                
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
