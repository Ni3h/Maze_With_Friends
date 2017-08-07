//
//  OptionsMenuBig.swift
//  Maze with Friends
//
//  Created by Ethan on 8/6/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class OptionsMenuBig: SKNode {
    
    var myMazesButton: MSButtonNode!
    var backToBuildButton: MSButtonNode!
    var continueButton: MSButtonNode!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        myMazesButton = self.childNode(withName: "//myMazesButton") as! MSButtonNode
        backToBuildButton = self.childNode(withName: "//backToBuildButton") as! MSButtonNode
        continueButton = self.childNode(withName: "//continueButton") as! MSButtonNode
        
        continueButton.selectedHandler = { [unowned self] in
            self.alpha = 0
        }
        
        
    }
    
    
}
