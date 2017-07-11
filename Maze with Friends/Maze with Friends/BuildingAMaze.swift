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
    
    var cam: SKCameraNode!
    
    let mazeObject = Maze()
    
    
    override func didMove(to view: SKView) {
        cam = SKCameraNode() //initialize and assign an instance of SKCameraNode to the cam variable.
        self.camera = cam //set the scene's camera to reference cam
        self.addChild(cam) //make the cam a childElement of the scene itself.
        cam.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        toolBar = self.childNode(withName: "toolBar") as! SKSpriteNode
        self.addChild(mazeObject)
        
        let width = self.size.width
        
        let toolBarHeight = toolBar.size.height
        
        
        mazeObject.generateGrid(rows: 49, columns: 49, width: Int(width), yOffset: toolBarHeight)
        
        mazeObject.mazeDimensions()
     
        
        
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
        let firstTouch = touches.first
        let location = (firstTouch?.location(in: self))!
        cam.position = location
    }
    
    
    
    
    
    
}
