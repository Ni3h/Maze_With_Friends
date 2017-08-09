//
//  VictoryMenu.swift
//  Maze with Friends
//
//  Created by Ethan on 8/8/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class VictoryMenu: SKNode {
    
    var victoryButton: MSButtonNode!
    var victoryBackground: ToolBarNode!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        victoryBackground = self.childNode(withName: "//victoryBackground") as! ToolBarNode
        victoryButton = self.childNode(withName: "//victoryButton") as! MSButtonNode
    }
    
    
}
