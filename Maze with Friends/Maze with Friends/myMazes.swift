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
    var mazeButtonArray = [mazeName]()
    
    
    var myMazeDictionary = [String: String]()
    var toolBar: ToolBarNode!
    var toolBarHeight: CGFloat = 0
    var nameOfButton = ""
 //   var goFlag: Bool = false
    
    
    override func didMove(to view: SKView) {
        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
        toolBarHeight = toolBar.size.height
        

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
                
                
                self.addButtonsToScene(nameArray: self.mazeNameArray, yOffset: self.toolBarHeight)
                
            }
        })
     
    }
    
    func addButtonsToScene(nameArray: [String], yOffset: CGFloat) {
        let count = nameArray.count
        
        let height = self.size.height

        let cgWidth = CGFloat(self.size.width)
        let cgHeight = CGFloat(height/7)
        
        
        let heightOfObject = CGFloat(height/7)

        
        for i in 0 ..< count {
            let path = Bundle.main.path(forResource: "mazeName", ofType: "sks")
            let mazeButtonObject = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            var mazeNameObject = mazeButtonObject.childNode(withName: "//mazeNameNode") as! mazeName
            
            mazeNameObject.playMaze()

            mazeNameObject.mazeNameLabel.text = nameArray[i]

            mazeNameObject.selectedHandler = {
                self.loadPlayScene(nameOfButton: nameArray[i])
                
            }
            

            
            let objectPosition  = CGPoint(x: 0, y: ((CGFloat(height) - yOffset - (cgHeight * CGFloat(i + 1)))))
            mazeButtonObject.position = objectPosition

            addChild(mazeButtonObject)

        }
        
        
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
    

}
