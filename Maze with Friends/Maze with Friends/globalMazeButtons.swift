//
//  globalMazeButtons.swift
//  Maze with Friends
//
//  Created by Ethan on 8/5/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import SpriteKit

class globalMazeButtons: MSButtonNode {
    
    /* UI Connections */
    var mazeNameLabel: SKLabelNode!
    var backroundNode: SKSpriteNode!
    var touchesMovedFlag = false
    weak var SKSceneReference: globalMazes?
    
    
    
    
    func playMaze() {
        mazeNameLabel = self.childNode(withName: "//mazeNameLabel") as! SKLabelNode
        backroundNode = self.childNode(withName: "//backroundNode") as! SKSpriteNode
    }
    
    
    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Touch handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesMovedFlag = false
        state = .MSButtonNodeStateSelected
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            let deltaX = previousLocation.x - location.x
            let deltaY = previousLocation.y - location.y
            
            if (abs(deltaX) > 1 || abs(deltaY) > 1 ) {
                touchesMovedFlag = true
                state = .MSButtonNodeStateActive
            }
            SKSceneReference?.scrollScene(deltaY: deltaY)
            
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchesMovedFlag == false {
            selectedHandler()
        }
        state = .MSButtonNodeStateActive
        
    }
    
    
    
    
    
    
    
}





