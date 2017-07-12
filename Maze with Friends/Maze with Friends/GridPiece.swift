//
//  GridPiece.swift
//  Maze with Friends
//
//  Created by Ethan on 7/10/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class GridPiece: SKSpriteNode {
    
    init() {
        /* Initialize with 'GridPiece' asset */
        let texture = SKTexture(imageNamed: "GridPiece")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())

        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 4
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    
    
    /* You are required to implement this for your sublcass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
