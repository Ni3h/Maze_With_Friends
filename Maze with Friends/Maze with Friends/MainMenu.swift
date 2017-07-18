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
    var buildButton: MSButtonNode!
    var playButton: MSButtonNode!
    
    
    override func didMove(to view: SKView) {
        /* Set UI connections */
        buildButton = self.childNode(withName: "buildButton") as! MSButtonNode
        playButton = self.childNode(withName: "playButton") as! MSButtonNode
        
        buildButton.selectedHandler = {
            self.loadBuildScene()
        }
        
        playButton.selectedHandler = {
            self.loadPlayScene()
        }
        
    }
    

    
    func loadBuildScene() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = BuildingAMaze(fileNamed:"BuildingAMaze") else {
            print("Could not make BuildingAMaze, check the name is spelled correctly")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
    func loadPlayScene() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = PlayingAMaze(fileNamed:"PlayingAMaze") else {
            print("Could not make PlayingAMaze, check the name is spelled correctly")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
    

}