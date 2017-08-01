//
//  MenuBar.swift
//  Maze with Friends
//
//  Created by Ethan on 7/17/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class MenuBar: SKScene {
    
    /* UI Connections */
    var buildButton: MSButtonNode!
    var solveButton: MSButtonNode!
    var friendsButton: MSButtonNode!
    var bar: ToolBarNode!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buildButton = self.childNode(withName: "buildButton") as! MSButtonNode
        solveButton = self.childNode(withName: "solveButton") as! MSButtonNode
        friendsButton = self.childNode(withName: "friendsButton") as! MSButtonNode
        bar = self.childNode(withName: "bar") as! ToolBarNode
        
    }
    

    
}
