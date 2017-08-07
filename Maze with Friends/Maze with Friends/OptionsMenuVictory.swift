//
//  OptionsMenuVictory.swift
//  Maze with Friends
//
//  Created by Ethan on 8/6/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class OptionsMenuVictory: SKNode {
    
    var buildFromVictoryButton: MSButtonNode!
    var saveButton: MSButtonNode!
    var background: ToolBarNode!
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        buildFromVictoryButton = self.childNode(withName: "//buildFromVictoryButton") as! MSButtonNode
        saveButton = self.childNode(withName: "//saveButton") as! MSButtonNode
        background = self.childNode(withName: "//background") as! ToolBarNode
        
    }
    
    
}
