//
//  OptionsMenuSmall.swift
//  Maze with Friends
//
//  Created by Ethan on 8/6/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class OptionsMenuSmall: SKNode {
    
    var exitButton: MSButtonNode!
    var backToMenuButton: MSButtonNode!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        
        exitButton = self.childNode(withName: "//exitButton") as! MSButtonNode
        backToMenuButton = self.childNode(withName: "//backToMenuButton") as! MSButtonNode
        
        exitButton.selectedHandler = { [unowned self] in
            self.alpha = 0
  
        }
    
    }
     
    
    
}
