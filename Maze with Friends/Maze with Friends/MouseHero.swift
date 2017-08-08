//
//  Hero
//  Maze with Friends
//
//  Created by Ethan on 7/12/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class MouseHero: Wall {
    
    init(size: CGSize, position: CGPoint) { 
        /* Initialize with 'FloorTiles' asset */
        
        let texture = SKTexture(imageNamed: "Dwarf_Front_IDLE")
        
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        self.position = position
        self.type = "hero"
        self.zPosition = 6
    }
    
    
    /* You are required to implement this for your sublcass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

