    //
//  PlayingAMaze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/18/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import SpriteKit
import AudioToolbox
import AVFoundation



class PlayingAMaze: SKScene {
    
    enum GameSceneState {
        case active, victory
    }
    
    enum direction {
        case N, E, S, W, X
    }

    
    var mazeSave: SaveMazeManager!
    
    /* Game management */
    var gameState: GameSceneState = .active
    
    var gridX = 0
    var gridY = 0
    var heroGridX = 0
    var heroGridY = 0
    var player: AVAudioPlayer!
    
    var finishLineGridX = 0
    var finishLineGridY = 0
    
    var didItScroll = false
    let screenSize = UIScreen.main.bounds
    var cam: SKCameraNode!
    
    var toolBar: ToolBarNode!
    var backMainMenu: MSButtonNode!
    var victoryButton: MSButtonNode!
    
    var toolBarHeight: CGFloat = 0
    var width = 0
    
    var mouseHeroObject: MouseHero!
    var finishLineObject: FinishLine!
    var nameToUse: String!
    

    
    override func didMove(to view: SKView) {
        /* Create a new Camera */
        cam = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cam
        
        toolBar = self.childNode(withName: "//toolBar") as! ToolBarNode
        backMainMenu = self.childNode(withName: "//backMainMenu") as! MSButtonNode
        victoryButton = self.childNode(withName: "//victoryButton") as! MSButtonNode
        
        
        backMainMenu.selectedHandler = { [unowned self] in
            self.loadMainMenu()
        }
        
        playSound()
        

        width = Int(self.size.width)
        toolBarHeight = toolBar.size.height

        mazeSave.mazeObject.placeInitialHero(row: 0, col: 0, yOffset: toolBarHeight)
        mouseHeroObject = mazeSave.mazeObject.heroObject
        
        
        mazeSave.mazeObject.placeInitialFinishLine(row: 1, col: 1, yOffset: toolBarHeight)
        finishLineObject = mazeSave.mazeObject.finishLineObject

        
        let tileSize = mazeSave.mazeObject.tileSize()
        
        let finishLineLocation = finishLineObject.convert(CGPoint(x: 0, y: 0), to: self)
        print(finishLineLocation.x)
        print(finishLineLocation.y)

        
      //  finishLineObject = mazeSave.mazeObject.finishLineObject
        finishLineGridX = Int(finishLineLocation.x / tileSize.tileWidth)
        print (finishLineGridX)
        finishLineGridY = Int((finishLineLocation.y - toolBarHeight) / tileSize.tileHeight)
        print (finishLineGridY)
//
        
        /* Setup restart button selection handler */
        victoryButton.selectedHandler = { [unowned self] in
            
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
        
        /* Hide restart button */
        victoryButton.state = .MSButtonNodeStateHidden

    }
    
    //MARK:- PLAY SOUND
    func playSound() {
        let url = Bundle.main.url(forResource: "maze_explore_01_v01", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    func getName(nameOfButton: String) {
        nameToUse = nameOfButton
    }
    
    func loadMaze(callback: @escaping () -> Void) {
        //load your maze data
        
        let width = self.size.width
        mazeSave = SaveMazeManager( width: Int(width), yOffset: 200 )
        mazeSave.mazeObject.gridLayer.zPosition = 0
        
        
        
        mazeSave.loadFromFirebase(mazeName: nameToUse) {
            callback()
        }
        self.addChild(mazeSave.mazeObject)
        
        //once finished
    }
    
    
    
    
    func loadMazeWhileBuilding(callback: @escaping () -> Void) {
        
        let width = self.size.width
        mazeSave = SaveMazeManager( width: Int(width), yOffset: 200)
        mazeSave.mazeObject.gridLayer.zPosition = 0
        mazeSave.loadFromPlist {
            callback()
        }
        
        self.addChild(mazeSave.mazeObject)
        
    }
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Disable touch if game state is not active */
        if gameState != .active { return }
        
        didItScroll = false
        
        
        let tileSize = mazeSave.mazeObject.tileSize()
        let touch = touches.first!
        let location = touch.location(in: self)
        let heroLocation = mouseHeroObject.convert(CGPoint(x: 0, y: 0), to: self)
        
        gridX = Int(location.x / tileSize.tileWidth)
        gridY = Int((location.y - toolBarHeight) / tileSize.tileHeight)
        heroGridX = Int(heroLocation.x / tileSize.tileWidth)
        heroGridY = Int((heroLocation.y - toolBarHeight) / tileSize.tileHeight)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState != .active { return }

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
            let dir = travelDirection(gX: gridX, gY: gridY, hX: heroGridX, hY: heroGridY)
            moveHero( dir: dir, gX: gridX, gY: gridY, hX: heroGridX, hY: heroGridY )
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        /* Skip game update if game no longer active */
        if gameState != .active { return }
        
       
        
        clampCameraToHero()
        clampCamera()
        
        if heroGridX == finishLineGridX && heroGridY == finishLineGridY {
            gameState = .victory
            /* Show restart button */
            victoryButton.state = .MSButtonNodeStateActive
        } else {
            return
        }
    }
    
    func clampCameraToHero(){
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let heroSize = mouseHeroObject.size
        let heroWidth = heroSize.width
        let heroHeight = heroSize.height

        
        let heroPosition = mouseHeroObject.convert(CGPoint(x: 0, y: 0), to: self)

        
        let rBoundary = heroPosition.x + screenWidth - (heroWidth)
        let lBoundary = heroPosition.x - (screenWidth-heroWidth)
        let tBoundary = heroPosition.y + screenHeight - toolBarHeight
        let bBoundary = heroPosition.y - (screenHeight) - (heroHeight/2) + toolBarHeight
        
        
        let targetX = camera!.position.x
        let targetY = camera!.position.y
        
        let x = clamp(value: targetX, lower: lBoundary, upper: rBoundary)
        let y = clamp(value: targetY, lower: bBoundary, upper: tBoundary)
        
        cam.position.x = x
        cam.position.y = y
        
        
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


    /* Figuring out the direction for the hero to move */
    func travelDirection(gX: Int, gY: Int, hX: Int, hY: Int) -> direction {
        if gX == hX {
            return (gY == hY ? .X : (gY < hY ? .S : .N))
        } else if gY == hY {
            return (gX == hX ? .X : (gX < hX ? .W : .E))
        } else {
            return .X
        }
    }
    
    
    func moveHero( dir: direction, gX: Int, gY: Int, hX: Int, hY: Int ) {
        let myMaze = mazeSave.mazeObject
        let tileSize = myMaze.tileSize()
        let tileWidth = tileSize.tileWidth
        let tileHeight = tileSize.tileHeight
        let baseDuration = 0.4
        var nextX: Int
        var nextY: Int
        var move: SKAction
        

        switch dir {
        case .N:
            nextY = hY + 1
            while nextY <= gY && !myMaze.isActualWall(gridX: gX, gridY: nextY){
                nextY += 1
            }
            nextY -= 1
            nextX = hX
            move = SKAction.moveTo(y: (CGFloat(nextY) * tileHeight) + toolBarHeight, duration: Double(abs(nextY - hY)) * baseDuration)
        case .S:
            nextY = hY - 1
            while nextY >= gY && !myMaze.isActualWall(gridX: gX, gridY: nextY){
                nextY -= 1
            }
            nextY += 1
            nextX = hX
            move = SKAction.moveTo(y: (CGFloat(nextY) * tileHeight) + toolBarHeight, duration: Double(abs(nextY - hY)) * baseDuration)
        case .E:
            nextX = hX + 1
            while nextX <= gX && !myMaze.isActualWall(gridX: nextX, gridY: gY){
                nextX += 1
            }
            nextX -= 1
            nextY = hY
            
            let count = nextX - hX
            
            print(count)
            mouseHeroObject.run(SKAction.repeat(SKAction.init(named: "DwarfRightWalk")!, count: count))
            move = SKAction.moveTo(x: CGFloat(nextX) * tileWidth, duration: Double(abs(nextX - hX)) * baseDuration)
        case .W:
            nextX = hX - 1
            while nextX >= gX && !myMaze.isActualWall(gridX: nextX, gridY: gY){
                nextX -= 1
            }
            nextX += 1
            nextY = hY
            
            let count = hX - nextX
            mouseHeroObject.run(SKAction.repeat(SKAction.init(named: "DwarfLeftWalk")!, count: count))
            move = SKAction.moveTo(x: CGFloat(nextX) * tileWidth, duration: Double(abs(nextX - hX)) * baseDuration)
            
        case .X:
            return

        }
        
        mouseHeroObject.run(move)
    }
    

    
    
    /* Button handlers */
    func loadMainMenu() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = myMazes(fileNamed:"myMazes") else {
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
