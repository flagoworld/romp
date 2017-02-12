//
//  Sprite.swift
//  Romp
//
//  Created by Ryan Layne on 1/26/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import SpriteKit
import GameplayKit

class Sprite : GKComponent {

    let node: SKSpriteNode

    init(texture: SKTexture) {
    
        node = SKSpriteNode(texture: texture, size: texture.size());
        
        super.init()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRepeating(_ repeating: Bool) {
    
        if repeating {
        
/*

  CGSize coverageSizePixels = CGSizeMake(backgroundSizePoints.width * screenScale, backgroundSizePoints.height * screenScale);
  
  CGSize coverageSizePoints = CGSizeMake(coverageSizePixels.width / screenScale, coverageSizePixels.height / screenScale);

  float outSampleHalfPixelOffsetX = 1.0f / (2.0f * ((float)coverageSizePixels.width));
  float outSampleHalfPixelOffsetY = 1.0f / (2.0f * ((float)coverageSizePixels.height));
  
  [shader addUniform:[SKUniform uniformWithName:@"outSampleHalfPixelOffset" floatVector2:GLKVector2Make(outSampleHalfPixelOffsetX, outSampleHalfPixelOffsetY)]];
  
  // normalized width passed into mod operation
  
  float tileWidth = tileSizePixels.width;
  float tileHeight = tileSizePixels.height;
  
  [shader addUniform:[SKUniform uniformWithName:@"tileSize" floatVector2:GLKVector2Make(tileWidth, tileHeight)]];
  
  // Tile pixel width and height
  
  float inSampleHalfPixelOffsetX = 1.0f / (2.0f * ((float)tileSizePixels.width));
  float inSampleHalfPixelOffsetY = 1.0f / (2.0f * ((float)tileSizePixels.height));
  
  [shader addUniform:[SKUniform uniformWithName:@"inSampleHalfPixelOffset" floatVector2:GLKVector2Make(inSampleHalfPixelOffsetX, inSampleHalfPixelOffsetY)]];

*/
        
            let useOgl = MTLCreateSystemDefaultDevice() == nil
            
            
            let shader = SKShader(fileNamed: useOgl ? "repeating_ogl.fsh" : "repeating_mtl.fsh")
            
            shader.addUniform(SKUniform(name: "outSampleHalfPixelOffset", float: GLKVector2(v: (0.0, 0.0))))
            shader.addUniform(SKUniform(name: "tileSize", float: GLKVector2(v: (0.0, 0.0))))
            shader.addUniform(SKUniform(name: "inSampleHalfPixelOffset", float: GLKVector2(v: (0.0, 0.0))))
            
            node.shader = shader
        
        } else {
        
            node.shader = nil
        
        }
    
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if let shader = node.shader {
        
            let outSampleHalfPixelOffsetX: Float = 1.0 / Float(2.0 * node.size.width)
            let outSampleHalfPixelOffsetY: Float = 1.0 / Float(2.0 * node.size.height)
            let tileSizeX: Float = Float(node.texture!.size().width)
            let tileSizeY: Float = Float(node.texture!.size().height)
            let inSampleHalfPixelOffsetX: Float = 1.0 / Float(2.0 * node.texture!.size().width)
            let inSampleHalfPixelOffsetY: Float = 1.0 / Float(2.0 * node.texture!.size().height)
            
            let outSampleHalfPixelOffset = shader.uniformNamed("outSampleHalfPixelOffset")
            let tileSize = shader.uniformNamed("tileSize")
            let inSampleHalfPixelOffset = shader.uniformNamed("inSampleHalfPixelOffset")
            
            outSampleHalfPixelOffset?.floatVector2Value = GLKVector2(v: (outSampleHalfPixelOffsetX, outSampleHalfPixelOffsetY))
            tileSize?.floatVector2Value = GLKVector2(v: (tileSizeX, tileSizeY))
            inSampleHalfPixelOffset?.floatVector2Value = GLKVector2(v: (inSampleHalfPixelOffsetX, inSampleHalfPixelOffsetY))
        
        }
        
    }

}
