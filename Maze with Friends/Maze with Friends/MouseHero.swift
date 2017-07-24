//
//  Hero
//  Maze with Friends
//
//  Created by Ethan on 7/12/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class MouseHero: Wall {
    var isAlive: Bool = false {
        didSet {
            /* Visibility */
            isHidden = !isAlive
        }
    }
    
    init() {
        // Make a texture from an image, a color, and size
        let texture = SKTexture(imageNamed: "MouseHero")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 5
        
        /* Set anchor point to bottom-left */
        anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

