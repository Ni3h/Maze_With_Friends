//
//  BuildingAMaze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/10/17.
//  Copyright © 2017 Ethan. All rights reserved.
//



import SpriteKit

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}


class BuildingAMaze: SKScene {
    var toolBar: SKSpriteNode!
    var settingsButton: SKSpriteNode!
    var saveButton: SKSpriteNode!
    var toolBarHeight: CGFloat = 0
    var gridX = 0
    var gridY = 0
    
    var didItScroll = false
    
    
    var cam: SKCameraNode!
    
    let mazeObject = Maze()
    
    
    override func didMove(to view: SKView) {
        /* Create a new Camera */
        cam = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cam
      //  cam.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        /*Initializing toolbar/buttons */
        toolBar = self.childNode(withName: "//toolBar") as! SKSpriteNode
        settingsButton = self.childNode(withName: "//settingsButton") as! SKSpriteNode
        saveButton = self.childNode(withName: "//saveButton") as! SKSpriteNode
        
        self.addChild(mazeObject)
        
        let width = self.size.width
        
        toolBarHeight = toolBar.size.height
        
        
        mazeObject.generateGrid(rows: 10, columns: 10, width: Int(width), yOffset: toolBarHeight)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        clampCamera()
    }
    
    func clampCamera(){
        let clampTuple = mazeObject.mazeDimensions()
        
        let lBoundary = self.size.width/2
        let bBoundary = self.size.height/2
        let rBoundary = clampTuple.x - (self.size.width/2)
        let tBoundary = clampTuple.y - (self.size.height/2)
        
        
        
        let targetX = camera!.position.x
        let targetY = camera!.position.y

        let x = clamp(value: targetX, lower: lBoundary, upper: rBoundary)
        let y = clamp(value: targetY, lower: bBoundary, upper: tBoundary)
        
        cam.position.x = x
        cam.position.y = y
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didItScroll = false
        print("touch regisered")
        let tileSize = mazeObject.tileSize()
        let touch = touches.first!
        let location = touch.location(in: self)
        
        gridX = Int(location.x / tileSize.tileWidth)
        gridY = Int((location.y - toolBarHeight) / tileSize.tileHeight)
        print(gridX)
        print(gridY)
        
//        let wallPiece = mazeObject.isometricWallArray[gridY][gridX]
//        wallPiece.isAlive = !wallPiece.isAlive
        

    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            didItScroll = true
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let deltaX = previousLocation.x - location.x
            let deltaY = previousLocation.y - location.y 
            cam.position.x += deltaX
            cam.position.y += deltaY
            
            
        }
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if didItScroll == false {
            print("touches ended")
            print(gridX)
            print(gridY)
            let wallPiece = mazeObject.isometricWallArray[gridY][gridX]
            wallPiece.isAlive = !wallPiece.isAlive
        } else { return }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if didItScroll == false {
            print("touches canceled")
            print(gridX)
            print(gridY)
            let wallPiece = mazeObject.isometricWallArray[gridY][gridX]
            wallPiece.isAlive = !wallPiece.isAlive
        } else { return }
    }
    
    
    
}
