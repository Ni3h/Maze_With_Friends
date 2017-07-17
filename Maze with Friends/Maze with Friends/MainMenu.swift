//
//  MainMenu.swift
//  Maze with Friends
//
//  Created by Ethan on 7/17/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    /* UI Connections */
    var solveButton: MSButtonNode!
    var buildButton: MSButtonNode!
    var toolBar: ToolBarNode!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */

        /* Set UI connections */
        solveButton = self.childNode(withName: "solveButton") as! MSButtonNode
        buildButton = self.childNode(withName: "buildButton") as! MSButtonNode
        toolBar = self.childNode(withName: "toolBar") as! ToolBarNode

    }
    
    
    
    
    
}
