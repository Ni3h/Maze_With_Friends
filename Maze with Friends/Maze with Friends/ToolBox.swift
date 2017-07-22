//
//  ToolBox.swift
//  Maze with Friends
//
//  Created by Ethan on 7/21/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class ToolBox: SKNode {
    
    
    /* UI Connections */
    var toolBoxLeft: MSButtonNode!
    var toolBoxRight: MSButtonNode!
    var closeButton: MSButtonNode!
    var endFlag: MSButtonNode!
    var startFlag: MSButtonNode!
    var toolBoxInside: ToolBarNode!
    var toolBoxOutside: ToolBarNode!
    var toolBoxNode: SKNode!
    
    var startFlagBoolFlag = false

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addChildren() -> Bool {
        toolBoxLeft = self.childNode(withName: "//toolBoxLeft") as! MSButtonNode
        toolBoxRight = self.childNode(withName: "//toolBoxRight") as! MSButtonNode
        closeButton = self.childNode(withName: "//closeButton") as! MSButtonNode
        endFlag = self.childNode(withName: "//endFlag") as! MSButtonNode
        startFlag = self.childNode(withName: "//startFlag") as! MSButtonNode
        toolBoxInside = self.childNode(withName: "//toolBoxInside") as! ToolBarNode
        toolBoxOutside = self.childNode(withName: "//toolBoxOutside") as! ToolBarNode
        
        
        closeButton.selectedHandler = { [unowned self] in
            self.alpha = 0
            
        }
        
        
        return startFlagBoolFlag
    }

    
 
    
}
