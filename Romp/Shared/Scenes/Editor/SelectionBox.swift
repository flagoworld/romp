//
//  SelectionBox.swift
//  Romp
//
//  Created by Ryan Layne on 2/8/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit

class SelectionBox: Equatable {

    
    let scene: SKScene
    var node: SKSpriteNode
    
    let topLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let topRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let outline = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    
    var grabAnchorPoint: CGPoint? = nil
    
    init(scene: SKScene, node: SKSpriteNode) {
    
        self.scene = scene
        self.node = node
        
        addToScene()
        redrawSelection()
    
        topLeftHandle.fillColor = NSColor.red
        topLeftHandle.zPosition = 2
        topLeftHandle.lineWidth = 0
        
        topRightHandle.fillColor = NSColor.red
        topRightHandle.zPosition = 2
        topRightHandle.lineWidth = 0
        
        bottomRightHandle.fillColor = NSColor.red
        bottomRightHandle.zPosition = 2
        bottomRightHandle.lineWidth = 0
        
        bottomLeftHandle.fillColor = NSColor.red
        bottomLeftHandle.zPosition = 2
        bottomLeftHandle.lineWidth = 0
        
        outline.fillColor = NSColor.clear
        outline.strokeColor = NSColor.red
        outline.lineWidth = 1
        outline.zPosition = 1
    
    }
    
    deinit {
    
        removeFromScene()
    
    }
    
    func redrawSelection() {
    
        topLeftHandle.position = CGPoint(x: node.position.x - (node.size.width / 2), y: node.position.y + (node.size.height / 2))
        topRightHandle.position = CGPoint(x: node.position.x + (node.size.width / 2), y: node.position.y + (node.size.height / 2))
        bottomRightHandle.position = CGPoint(x: node.position.x + (node.size.width / 2), y: node.position.y - (node.size.height / 2))
        bottomLeftHandle.position = CGPoint(x: node.position.x - (node.size.width / 2), y: node.position.y - (node.size.height / 2))
        
        outline.path = CGPath(rect: node.frame, transform: nil)
    
    }
    
    private func addToScene() {
    
        scene.addChild(topLeftHandle)
        scene.addChild(topRightHandle)
        scene.addChild(bottomRightHandle)
        scene.addChild(bottomLeftHandle)
        scene.addChild(outline)
    
    }
    
    private func removeFromScene() {
    
        topLeftHandle.removeFromParent()
        topRightHandle.removeFromParent()
        bottomRightHandle.removeFromParent()
        bottomLeftHandle.removeFromParent()
        outline.removeFromParent()
    
    }
    
    func grabHandle(_ mouseLocation: CGPoint) -> Bool {
    
        if topLeftHandle.contains(mouseLocation) {
        
            grabAnchorPoint = bottomRightHandle.position
        
        } else if topRightHandle.contains(mouseLocation) {
        
            grabAnchorPoint = bottomLeftHandle.position
        
        } else if bottomRightHandle.contains(mouseLocation) {
        
            grabAnchorPoint = topLeftHandle.position
        
        } else if bottomLeftHandle.contains(mouseLocation) {
        
            grabAnchorPoint = topRightHandle.position
        
        } else {
        
            self.grabAnchorPoint = nil
            
            return false
        
        }
        
        return true
    
    }
    
    func moveHandle(_ mouseLocation: CGPoint) -> Bool {
    
        if grabAnchorPoint != nil {
        
            let newFrame = CGRect(x: grabAnchorPoint!.x, y: grabAnchorPoint!.y, width: 0, height: 0).union(CGRect(x: mouseLocation.x, y: mouseLocation.y, width: 0, height: 0))
            
            node.size = newFrame.size
            node.position = CGPoint(x: newFrame.midX, y: newFrame.midY)
            
            redrawSelection()
            
            return true
        
        }
        
        return false
    
    }
    
    func releaseHandle() {
    
        grabAnchorPoint = nil
    
    }
    
    // MARK: Equatable
    
    static func ==(lhs: SelectionBox, rhs: SelectionBox) -> Bool {
    
        return lhs === rhs
        
    }

}
