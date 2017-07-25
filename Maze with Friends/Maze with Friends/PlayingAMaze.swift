//
//  PlayingAMaze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/18/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit



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

    let finishLineObject = FinishLine()
    
    var mouseHeroObject: MouseHero!


    
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
        

        width = Int(self.size.width)
        toolBarHeight = toolBar.size.height
        mazeSave = SaveMazeManager( width: Int(width), yOffset: toolBarHeight )
        
        mazeSave.mazeObject.placeInitialHero(row: 0, col: 0, yOffset: toolBarHeight)
        
        
        self.addChild(mazeSave.mazeObject)

        mouseHeroObject = mazeSave.mazeObject.heroObject
        
        mazeSave.mazeObject.gridLayer.zPosition = 0
        
  //      addMouse(row: 0, col: 1, yOffset: toolBarHeight)
        addFinishLine(row: 24, col: 23, yOffset: toolBarHeight)
        
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
        
        if heroGridX == 23 && heroGridY == 23 {
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
        let tileSize = mazeSave.mazeObject.tileSize()
        let tileWidth = tileSize.tileWidth
        let tileHeight = tileSize.tileHeight
        
        let heroPosition = mouseHeroObject.convert(CGPoint(x: 0, y: 0), to: self)

        
        let rBoundary = heroPosition.x + screenWidth
        let lBoundary = heroPosition.x - (screenWidth-heroWidth)
        
        let tBoundary = heroPosition.y + screenHeight
        let bBoundary = heroPosition.y - (screenHeight-tileHeight) - (heroHeight*2)
        
        
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
    
    func addFinishLine(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        let tileSize = mazeSave.mazeObject.tileSize()
        let tileWidth = tileSize.tileWidth
        let tileHeight = tileSize.tileHeight
        
        /* New mouseHero object */
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
        
        finishLineObject.size.width = CGFloat(tileWidth)
        finishLineObject.size.height = CGFloat(tileHeight)
        
        finishLineObject.position = gridPosition
        
        let finishLinePosition = mouseHeroObject.convert(CGPoint(x: 0, y: 0), to: self)
        
        
        finishLineGridX = Int(finishLinePosition.x / tileSize.tileWidth)
        finishLineGridY = Int((finishLinePosition.y - toolBarHeight) / tileSize.tileHeight)
        
        
        addChild(finishLineObject)
        
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
        let baseDuration = 0.2
        var nextX: Int
        var nextY: Int
        var move: SKAction
        
     //   print("direction:\(dir) hX\(hX) hY \(hY) gx\(gX) gy\(gY)")


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
            move = SKAction.moveTo(x: CGFloat(nextX) * tileWidth, duration: Double(abs(nextX - hX)) * baseDuration)
        case .W:
            nextX = hX - 1
            while nextX >= gX && !myMaze.isActualWall(gridX: nextX, gridY: gY){
                nextX -= 1
            }
            nextX += 1
            nextY = hY
            move = SKAction.moveTo(x: CGFloat(nextX) * tileWidth, duration: Double(abs(nextX - hX)) * baseDuration)
            
        case .X:
            return

        }
        
       // print("nextX: \(nextX) nextY \(nextY)")

        
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
