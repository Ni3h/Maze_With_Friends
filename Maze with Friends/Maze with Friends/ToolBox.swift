//
//  ToolBox.swift
//  Maze with Friends
//
//  Created by Ethan on 7/21/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class ToolBox: SKNode {
    
    enum TBState {
        case TBInactive, TBPlaceStartPosition, TBFinishLinePosition
    }
    
    
    /* UI Connections */
    var toolBoxLeft: MSButtonNode!
    var toolBoxRight: MSButtonNode!
    var closeButton: MSButtonNode!
    var startPosition: MSButtonNode!
    var finishLinePosition: MSButtonNode!

    var toolBoxInside: ToolBarNode!
    var toolBoxOutside: ToolBarNode!
    var toolBoxNode: SKNode!
    
    
    /* Bool Flags for buttons */
    var currentTBState: TBState = .TBInactive
    
    var startPositionFlag = false
    var endPositionFlag = false

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addChildren() {
        toolBoxLeft = self.childNode(withName: "//toolBoxLeft") as! MSButtonNode
        toolBoxRight = self.childNode(withName: "//toolBoxRight") as! MSButtonNode
        closeButton = self.childNode(withName: "//closeButton") as! MSButtonNode
        
        startPosition = self.childNode(withName: "//startPosition") as! MSButtonNode
        finishLinePosition = self.childNode(withName: "//finishLinePosition") as! MSButtonNode
        toolBoxInside = self.childNode(withName: "//toolBoxInside") as! ToolBarNode
        toolBoxOutside = self.childNode(withName: "//toolBoxOutside") as! ToolBarNode
        
        
        closeButton.selectedHandler = { [unowned self] in
            self.alpha = 0
            
        }
        
        startPosition.selectedHandler = { [unowned self] in
            self.currentTBState = .TBPlaceStartPosition
        }
        

        
        finishLinePosition.selectedHandler = { [unowned self] in
            self.currentTBState = .TBFinishLinePosition
        }
        
        
        
        
        
        
    }

    
 
    
}
