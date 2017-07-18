//
//  PlayingAMaze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/18/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit


class PlayingAMaze: SKScene {
    
    let mazeSave = SaveMazeManager()

    var gridX = 0
    var gridY = 0

    
    override func didMove(to view: SKView) {
        self.addChild(mazeSave.mazeObject)
        
        mazeSave.mazeObject.gridLayer.zPosition = -10
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let tileSize = mazeSave.mazeObject.tileSize()
        let touch = touches.first!
        let location = touch.location(in: self)
        
        gridX = Int(location.x / tileSize.tileWidth)
        gridY = Int((location.y - 140) / tileSize.tileHeight)
        
        print("GridX")
        print(gridX)
        print("GridY")
        print(gridY)
        print()
        
        
    }
    
    func checkAliveWalls() {
        
    }
    
    
//    What is GridX, GridY of current location, what is touchGridX, touchGridY of touch
//    
//    
//    [1:49]
//    then check, that either the Xs or Ys are the same
//    
//    
//    [1:49]
//    then check that there is no wall between the two locations
//    
//    
//    [1:50]
//    then relocate hero, maybe with some animation steps along the way on the intervening tiles
//    
}
