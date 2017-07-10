//
//  BuildingAMaze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/10/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import SpriteKit

class BuildingAMaze: SKScene {
    var toolBar: SKSpriteNode!
    let mazeObject = Maze()
    
    
    override func didMove(to view: SKView) {
        toolBar = self.childNode(withName: "toolBar") as! SKSpriteNode
        self.addChild(mazeObject)
        
        let width = self.size.width
        
        
        mazeObject.generateGrid(rows: 5, columns: 5, width: Int(width))
     
        
        
    }
    
    
    
    
    
    
    
}
