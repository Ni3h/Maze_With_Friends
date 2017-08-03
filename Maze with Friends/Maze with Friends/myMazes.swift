//
//  myMazes.swift
//  Maze with Friends
//
//  Created by Ethan on 7/29/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SpriteKit



class myMazes: SKScene {
    
    
    var mazeSave: SaveMazeManager!
    let database = Database.database()
    var mazeNameArray = [String]()
    var mazeButtonArray = [mazeButtons]()
    
    
    var myMazeDictionary = [String: String]()
    var buildButton: MSButtonNode!
    var toolBar: ToolBarNode!
    
    var buildButtonHeight: CGFloat = 0
    var toolBarHeight: CGFloat = 0
    var yOffset: CGFloat = 0
    
    var nameOfButton = ""
    var cam: SKCameraNode!
    var cgHeight: CGFloat = 0


 //   var goFlag: Bool = false
    
    
    override func didMove(to view: SKView) {
        /* Create a new Camera */
        cam = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cam
        
        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
        buildButton = self.childNode(withName: "//buildButton") as! MSButtonNode
        
        toolBarHeight = toolBar.size.height
        buildButtonHeight = buildButton.size.height
        
        yOffset = toolBarHeight + buildButtonHeight
        
        
        
        buildButton.selectedHandler = { [unowned self] in
            self.loadBuildScene()
        }

        loadMazeArrayFromDatabase()
    }
    
    
    
    func loadMazeArrayFromDatabase() {
        let dataRef = database.reference()
        let uid = Auth.auth().currentUser!.uid
     
        dataRef.child("mazes").child(uid).observe(.value, with: { (snapshot) in
            
            if let value = snapshot.value as? NSDictionary {
                for key in value {
                    self.mazeNameArray.append(key.0 as! String)
                }
                
                
                self.addButtonsToScene(nameArray: self.mazeNameArray, yOffset: self.yOffset)
                
            }
        })
     
    }
    
    func addButtonsToScene(nameArray: [String], yOffset: CGFloat) {
        let count = nameArray.count
        let height = self.size.height

        for i in 0 ..< count {
            let path = Bundle.main.path(forResource: "mazeButtons", ofType: "sks")
            let mazeButtonObject = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            let mazeNameObject = mazeButtonObject.childNode(withName: "//mazeNameNode") as! mazeButtons
            mazeNameObject.playMaze()
            cgHeight = mazeNameObject.backroundNode.size.height
            mazeNameObject.mazeNameLabel.text = nameArray[i]
            mazeNameObject.selectedHandler = {
                self.loadPlayScene(nameOfButton: nameArray[i])
            }
            
            let objectPosition  = CGPoint(x: 0, y: ((CGFloat(height) - yOffset - (cgHeight * CGFloat(i + 1)))))
            mazeButtonObject.position = objectPosition
            mazeNameObject.SKSceneReference = self
            
            addChild(mazeButtonObject)
        }
    }
    
    func scrollScene(deltaY: CGFloat) {
        cam.position.y += deltaY
        clampCamera(nameArray: self.mazeNameArray, yOffset: self.yOffset)

    }
    
    func clampCamera(nameArray: [String], yOffset: CGFloat){
        let count = nameArray.count
        let heightOfButtons = CGFloat(count) * cgHeight
        print (self.size.height)
        print (heightOfButtons)
        
        
        let bBoundary = (self.size.height + (self.size.height/2)) - heightOfButtons - yOffset
        let tBoundary = self.size.height/2
        print (self.size.height)
        
        
        let targetY = camera!.position.y
        
        let y = clamp(value: targetY, lower: bBoundary, upper: tBoundary)
        print (cam.position.y)

        cam.position.y = y
    }

    func loadPlayScene(nameOfButton: String) {
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
        scene.scaleMode = .aspectFill
        
        scene.loadMaze() {
            skView.presentScene(scene)
        }
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true

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
        
        scene.loadMaze() {
            skView.presentScene(scene)
        }
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        //        skView.presentScene(scene)
    }
    

    

}
