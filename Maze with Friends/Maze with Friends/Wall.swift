//
//  Wall.swift
//  Maze with Friends
//
//  Created by Ethan on 7/12/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class Wall: SKSpriteNode {
    var isAlive: Bool = false {
        didSet {
            /* Visibility */
            isHidden = !isAlive
        }
    }
    
    var type = "dummy"
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)  {
        /* Initialize with 'FloorTiles' asset */
        super.init(texture: texture, color: color, size: size)
         
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 3
        print(self.isAlive)
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    
    
    
    /* You are required to implement this for your sublcass to work */
    required init?(coder aDecoder: NSCoder) {
        self.type = aDecoder.decodeObject(forKey: "wallSave") as! String
        self.isAlive = aDecoder.decodeBool(forKey: "aliveState")
        super.init(coder: aDecoder)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.type, forKey: "wallSave")
        aCoder.encode(self.isAlive, forKey: "aliveState")
        super.encode(with: aCoder)
    }
    
    
}
    

    


