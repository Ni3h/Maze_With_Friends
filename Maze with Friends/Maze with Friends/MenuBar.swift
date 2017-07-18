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
    
    
    
//    func loadMenuScene(fileName: String ) {
//        /* 1) Grab reference to our SpriteKit view */
//        guard let skView = self.view as SKView! else {
//            print("Could not get Skview")
//            return
//        }
//        
//        /* 2) Load Game scene */
//        guard let scene = MainMenu.menuPanel(fileName) else {
//            print("Could not make GameScene, check the name is spelled correctly")
//            return
//        }
//        
//        /* 3) Ensure correct aspect mode */
//        scene.scaleMode = .aspectFill
//        
//        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true
//        
//        /* 4) Start game scene */
//        skView.presentScene(scene)
//    }
//    
//    
   
    
}
