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
    var tapToBegin: SKLabelNode!
 
    
    override func didMove(to view: SKView) {
        /* Set UI connections */
        
        tapToBegin = self.childNode(withName: "tapToBegin") as! SKLabelNode
        
        let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0), SKAction.wait(forDuration: 1.0), SKAction.fadeOut(withDuration: 1.0)])
        
        tapToBegin.run(SKAction.repeatForever(animateList))
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func loadMaze(callback: () -> Void) {
        //load your maze data
        //once finished
        callback()
    }
    

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadMyMazesScene()
    }
    
    func loadMyMazesScene() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        //EDIT THIS
        var scene = myMazes(fileNamed:"myMazes")

        
        /* 3) Ensure correct aspect mode */
        scene?.scaleMode = .aspectFill
        
        
        scene?.loadMyMazes() {
            skView.presentScene(scene)
            scene = nil
        }
        
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
//        skView.presentScene(scene)
    }
    
    

}
