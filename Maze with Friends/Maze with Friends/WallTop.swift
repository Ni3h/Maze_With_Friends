//
//  File.swift
//  Maze with Friends
//
//  Created by Ethan on 7/12/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class WallTop: Wall {
    
    init() {
        /* Initialize with 'FloorTiles' asset */
        let texture = SKTexture(imageNamed: "WallTop")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
      //  self.size.width = Wall.size.width
      //  self.size.height = Wall.size.height
        
        
    }
    
    /* You are required to implement this for your sublcass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
