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
    
    var mazeSave: SaveMazeManager!
    
    var toolBar: ToolBarNode!
 //   var toolBox: ToolBarNode!
    var settingsButton: MSButtonNode!
    var saveButton: MSButtonNode!
    var backMainMenu: MSButtonNode!
    
    
    var toolBarHeight: CGFloat = 0
    var gridX = 0
    var gridY = 0
    
    var didItScroll = false
    
    
    var cam: SKCameraNode!
    
    override func didMove(to view: SKView) {
        /* Create a new Camera */
        cam = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cam
        
        /*Initializing toolbar/buttons */
        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
      //  toolBox = self.childNode(withName:"//toolBox") as! ToolBarNode
        settingsButton = self.childNode(withName: "//settingsButton") as! MSButtonNode
        saveButton = self.childNode(withName: "//saveButton") as! MSButtonNode
        backMainMenu = self.childNode(withName: "//backMainMenu") as! MSButtonNode
        
        let width = self.size.width
        
        toolBarHeight = toolBar.size.height
        mazeSave = SaveMazeManager( width: Int(width), yOffset: Int(toolBarHeight) )
        self.addChild(mazeSave.mazeObject)

        print(width)
        
        
        
      //  mazeSave.mazeObject.generateGrid(rows: 25, columns: 25, width: Int(width), yOffset: toolBarHeight)
        
        saveButton.selectedHandler = {
            self.mazeSave.save()
        }
        
        backMainMenu.selectedHandler = {
            self.loadMainMenu()
        }
        
    }
    
    
    func widthDimension() -> Int {
        let width = self.size.width
        return Int(width)
    }
    
    
    /* Update override */
    
    override func update(_ currentTime: TimeInterval) {
        clampCamera()
    }
    
    
    
    
    func clampCamera(){
        let clampTuple = mazeSave.mazeObject.mazeDimensions()
        
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

        let tileSize = mazeSave.mazeObject.tileSize()
        let touch = touches.first!
        let location = touch.location(in: self)
        
        gridX = Int(location.x / tileSize.tileWidth)
        gridY = Int((location.y - toolBarHeight) / tileSize.tileHeight)
        

    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            let deltaX = previousLocation.x - location.x
            let deltaY = previousLocation.y - location.y
            
            if (abs(deltaX) > 1 || abs(deltaY) > 1 ) {
                didItScroll = true
            }
            
            
            cam.position.x += deltaX
            cam.position.y += deltaY
            
            
        }
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if didItScroll == false {
           
            let wallPiece = mazeSave.mazeObject.wallArray[gridY][gridX]
            
            if wallPiece.isAlive {
                mazeSave.mazeObject.removeAWall(gridX: gridX, gridY: gridY)
            } else {
                mazeSave.mazeObject.placeAWall(gridX: gridX, gridY: gridY)

            }
            
        }
    }
    
    
    /* Button handlers */
    
    func loadMainMenu() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = MainMenu(fileNamed:"MainMenu") else {
            print("Could not make MainMenu, check the name is spelled correctly")
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
