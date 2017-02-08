//
//  SelectionBox.swift
//  Romp
//
//  Created by Ryan Layne on 2/8/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit

class SelectionBox {

    let topLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let topRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomRightHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let bottomLeftHandle = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    let outline = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    
    var selectedNode: SKSpriteNode? = nil
    var grabbedHandle: SKShapeNode? = nil
    var grabbedHandleStartFrame: CGRect? = nil
    
    init() {
    
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
    
    func setSelectedNode(_ node: SKSpriteNode?) {
    
        selectedNode = node
    
        if let node = node {
        
            topLeftHandle.position = CGPoint(x: node.position.x - (node.size.width / 2), y: node.position.y - (node.size.height / 2))
            topRightHandle.position = CGPoint(x: node.position.x + (node.size.width / 2), y: node.position.y - (node.size.height / 2))
            bottomRightHandle.position = CGPoint(x: node.position.x + (node.size.width / 2), y: node.position.y + (node.size.height / 2))
            bottomLeftHandle.position = CGPoint(x: node.position.x - (node.size.width / 2), y: node.position.y + (node.size.height / 2))
            
            outline.path = CGPath(rect: node.frame, transform: nil)
            
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
    
    func grabHandle(_ mouseLocation: CGPoint) -> Bool {
    
        if selectedNode == nil {
        
            return false
        
        }
    
        let grabbedHandle: SKShapeNode
        
        if topLeftHandle.contains(mouseLocation) {
        
            grabbedHandle = topLeftHandle
        
        } else if topRightHandle.contains(mouseLocation) {
        
            grabbedHandle = topRightHandle
        
        } else if bottomRightHandle.contains(mouseLocation) {
        
            grabbedHandle = topRightHandle
        
        } else if bottomLeftHandle.contains(mouseLocation) {
        
            grabbedHandle = topRightHandle
        
        } else {
        
            self.grabbedHandle = nil
            self.grabbedHandleStartFrame = nil
            
            return false
        
        }
        
        self.grabbedHandle = grabbedHandle
        self.grabbedHandleStartFrame = grabbedHandle.frame
        
        return true
    
    }
    
    func moveHandle(_ mouseLocation: CGPoint) -> Bool {
    
        if selectedNode != nil && grabbedHandleStartFrame != nil && grabbedHandle != nil {
        
            let newFrame = grabbedHandleStartFrame!.union(CGRect(x: mouseLocation.x, y: mouseLocation.y, width: 0, height: 0))
//            let newFrame = grabbedHandleStartFrame!
            
//            switch grabbedHandle {
//            
//            case topLeftHandle:
//                
//            
//            }
            
            selectedNode!.size = newFrame.size
            selectedNode!.position = CGPoint(x: newFrame.midX, y: newFrame.midY)
            
            setSelectedNode(selectedNode)
            
            return true
        
        }
        
        return false
    
    }
    
    func releaseHandle() {
    
        grabbedHandleStartFrame = nil
    
    }

}
