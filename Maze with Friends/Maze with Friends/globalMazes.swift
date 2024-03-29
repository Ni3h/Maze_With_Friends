//
//  globalMazes.swift
//  Maze with Friends
//
//  Created by Ethan on 8/5/17.
//  Copyright © 2017 Ethan. All rights reserved.
//


import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SpriteKit



class globalMazes: SKScene {
    
    
    var mazeSave: SaveMazeManager!
    let database = Database.database()
    var mazeNameArray = [String]()
    var mazeButtonArray = [globalMazeButtons]()
    
    
    var myMazeDictionary = [String: String]()
    var toolBar: ToolBarNode!
    
    var toolBarHeight: CGFloat = 0
    var yOffset: CGFloat = 0
    var globalBottomYOffset: CGFloat = 0
    
    var nameOfButton = ""
    var globalCam: SKCameraNode!
    var cgHeight: CGFloat = 0
    
    var goToGlobalMazesFromGlobal: MSButtonNode!
    var goToMyMazesFromGlobal: MSButtonNode!
    var menuButtonGlobal
    : MSButtonNode!
    var globalMazesBottomToolBar: ToolBarNode!
    
    var navOptionsMenuReference: NavOptionsMenu!

    
    
    override func didMove(to view: SKView) {
        /* Create a new Camera */
        globalCam = childNode(withName: "globalCameraNode") as! SKCameraNode
        self.camera = globalCam
        
//        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
//        
//        
//        globalMazesBottomToolBar = self.childNode(withName: "//globalMazesBottomToolBar") as! ToolBarNode
        goToGlobalMazesFromGlobal = self.childNode(withName: "//goToGlobalMazesFromGlobal") as! MSButtonNode
         goToMyMazesFromGlobal = self.childNode(withName: "//goToMyMazesFromGlobal") as! MSButtonNode
         menuButtonGlobal = self.childNode(withName: "//menuButtonGlobal") as! MSButtonNode
        
        /*Nav Options Menu Info!*/
        navOptionsMenuReference = self.childNode(withName: "//navOptionsMenuNode") as! NavOptionsMenu
        navOptionsMenuReference.addChildren()

        
        menuButtonGlobal.selectedHandler = { [unowned self] in
            if self.navOptionsMenuReference.alpha == 1 {
                self.navOptionsMenuReference.alpha = 0
            } else {
                self.navOptionsMenuReference.alpha = 1
            }
        }
        
        
        
        goToMyMazesFromGlobal.selectedHandler = { [unowned self] in
            self.loadMyMazesScene()
        }
        
//        toolBarHeight = toolBar.size.height
//        
//        yOffset = toolBarHeight
        
        
//        loadMazeArrayFromDatabase()
        
    }
    
    func loadGlobalMazes (callback: @escaping () -> Void) {
        
        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
        globalMazesBottomToolBar = self.childNode(withName: "//globalMazesBottomToolBar") as! ToolBarNode
        
        
        toolBarHeight = toolBar.size.height
        yOffset = toolBarHeight
        globalBottomYOffset = globalMazesBottomToolBar.size.height
        
        
        
        self.loadMazeArrayFromDatabase() {
            callback()
        }
    }
    
    
    
    func loadMazeArrayFromDatabase(completion: @escaping () -> Void) {
        let dataRef = database.reference()
        let uid = "kw6fkHPw9ITNUyHYtFN4ClkUtAX2"
        
        dataRef.child("mazes").child(uid).observe(.value, with: {
            [unowned self] (snapshot) in
            
            if let value = snapshot.value as? NSDictionary {
                for key in value {
                    self.mazeNameArray.append(key.0 as! String)
                }
                
                
                self.addButtonsToScene(nameArray: self.mazeNameArray, yOffset: self.yOffset)
                
            }
            completion()
        })
        
    }
    
    func addButtonsToScene(nameArray: [String], yOffset: CGFloat) {
        let count = nameArray.count
        let height = self.size.height
        
        for i in 0 ..< count {
            let path = Bundle.main.path(forResource: "globalMazeButtons", ofType: "sks")
            let mazeButtonObject = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            let mazeNameObject = mazeButtonObject.childNode(withName: "//mazeNameNode") as! globalMazeButtons
            mazeNameObject.playMaze()
            cgHeight = mazeNameObject.backroundNode.size.height
            mazeNameObject.mazeNameLabel.text = nameArray[i]
            mazeNameObject.selectedHandler = { [unowned self] in 
                self.loadPlaySceneGlobal(nameOfButton: nameArray[i])
            }
            
            let objectPosition  = CGPoint(x: 0, y: ((CGFloat(height) - yOffset - (cgHeight * CGFloat(i + 1)))))
            mazeButtonObject.position = objectPosition
            mazeNameObject.SKSceneReference = self
            
            addChild(mazeButtonObject)
        }
    }
    
    func scrollScene(deltaY: CGFloat) {
        globalCam.position.y += deltaY
        clampCamera(nameArray: self.mazeNameArray, yOffset: self.yOffset, bottomYOffset: self.globalBottomYOffset)
        
    }
    
    func clampCamera(nameArray: [String], yOffset: CGFloat, bottomYOffset: CGFloat){
        let count = nameArray.count
        let heightOfButtons = CGFloat(count) * cgHeight
        
        let bBoundary = (self.size.height + (self.size.height/2)) - heightOfButtons - yOffset - bottomYOffset
        let tBoundary = self.size.height/2
        
        let targetY = camera!.position.y
        
        let y = clamp(value: targetY, lower: bBoundary, upper: tBoundary)
        
        globalCam.position.y = y
    }
    
    func loadPlaySceneGlobal(nameOfButton: String) {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        //EDIT THIS
        
        
        guard let scene = PlayingAMaze(fileNamed:"PlayingAMaze") else {
            print("Could not make PlayingAMaze, check the name is spelled correctly")
            return
        }
        scene.getName(nameOfButton: nameOfButton)
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        
        scene.loadMazeGlobal() {
            skView.presentScene(scene)
        }
        
//        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true
        
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
        scene.scaleMode = .aspectFit
        

        
//        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
    
    func loadMyMazesScene() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        guard let scene = myMazes(fileNamed:"myMazes") else {
            print("Could not make MainMenu, check the name is spelled correctly")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        
        scene.loadMyMazes {
            skView.presentScene(scene)
        }
        
        
        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true


    }
    
    override func willMove(from view: SKView) {
        let dataRef = database.reference()
        let uid = "kw6fkHPw9ITNUyHYtFN4ClkUtAX2"
        dataRef.child("mazes").child(uid).removeAllObservers()
    }

    
    
    
    
}

