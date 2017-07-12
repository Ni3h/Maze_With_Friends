//
//  IsometricMazeWall.swift
//  Maze with Friends
//
//  Created by Ethan on 7/11/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class IsometricMazeWall: SKSpriteNode {
    
    
    var isAlive: Bool = false {
        didSet {
            /* Visibility */
            isHidden = !isAlive
        }
    }

    init() {
        /* Initialize with 'FloorTiles' asset */
        let texture = SKTexture(imageNamed: "IsometricWall")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    
    
    /* You are required to implement this for your sublcass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}



