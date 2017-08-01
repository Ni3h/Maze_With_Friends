//
//  mazeName.swift
//  Maze with Friends
//
//  Created by Ethan on 7/31/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
//
//  ToolBox.swift
//  Maze with Friends
//
//  Created by Ethan on 7/21/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class mazeName: MSButtonNode {
    
    /* UI Connections */
    var mazeNameLabel: SKLabelNode!
    
   
    
    func playMaze() {
        mazeNameLabel = self.childNode(withName: "//mazeNameLabel") as! SKLabelNode
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

    
    
    
    
    
    
}





