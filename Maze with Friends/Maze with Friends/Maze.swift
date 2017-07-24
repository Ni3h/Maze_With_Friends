//
//  Maze.swift
//  Maze with Friends
//
//  Created by Ethan on 7/10/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import Foundation
import SpriteKit

class Maze: SKSpriteNode {
    var gridArray =  [[GridPiece]]()
    var floorTileArray = [[FloorTiles]]()
    var wallArray = [[Wall]]()
    
    let heroObject = MouseHero()

    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    var gridXSize: CGFloat = 0
    var gridYSize: CGFloat = 0
    var maxRows = 0
    var maxCols = 0
    var gridLayer = SKNode()
    


    
    var backroundSizeDifference: Int = 2
    var backroundTileWidth: CGFloat = 0
    var backroundTileHeight: CGFloat = 0
    
    
    /* Calculate grid array position */
    
    func mazeDimensions() -> (x: CGFloat, y: CGFloat) {
        let x = gridXSize
        let y = gridYSize
        return (x, y)
    }
    
    func tileSize() -> (tileWidth: CGFloat, tileHeight: CGFloat){
        let x = tileWidth
        let y = tileHeight
        return(x, y)
        
    }
    
    /*WallTop Helper Function */
    func wallHelper(newWallPiece: Wall, gridX: Int, gridY: Int){
        newWallPiece.isAlive = true
        self.addChild(newWallPiece)
    }
    
    /* Checks to see if there is a wall at given gridX, gridY location */
    func isWall(gridX: Int, gridY: Int) -> Bool {
        let wallPiece = wallArray[gridY][gridX]
        return wallPiece.isAlive
    }
    
    
    /* Hero Starting Position Functions */
    func placeInitialHero(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        /* Calculate position on screen */

        
        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
        
        heroObject.size.width = CGFloat(tileWidth)
        heroObject.size.height = CGFloat(tileHeight)
        
        heroObject.position = gridPosition
        
        heroObject.isAlive = false
    
        addChild(heroObject)
        
    }
    
    
    
    func placeStartingPosition(gridX: Int, gridY: Int, yOffset: CGFloat) {
        while isWall(gridX: gridX, gridY: gridY) {
            self.removeAWall(gridX: gridX, gridY: gridY)
        }
        /* New heroObject object */
        let gridPosition = CGPoint(x: (CGFloat(gridX) * tileWidth) , y: ((CGFloat(gridY) * tileHeight) + yOffset))
        
        heroObject.size.width = CGFloat(tileWidth)
        heroObject.size.height = CGFloat(tileHeight)
        
        heroObject.position = gridPosition
        heroObject.isAlive = true

    }
    
    func placeAWall(gridX: Int, gridY: Int){
        let wallPiece = wallArray[gridY][gridX]
        
        if(gridY > 0 && wallArray[gridY - 1][gridX].isAlive){
            let newWallTop = WallTop(size: wallPiece.size, position: wallPiece.position)
            wallHelper(newWallPiece: newWallTop, gridX: gridX, gridY: gridY)
            wallArray[gridY][gridX] = newWallTop
            
            wallPiece.isAlive = false
            wallPiece.removeFromParent()
        } else {
            let newIsoWall = IsometricMazeWall(size: wallPiece.size, position: wallPiece.position)
            wallHelper(newWallPiece: newIsoWall, gridX: gridX, gridY: gridY)
            wallArray[gridY][gridX] = newIsoWall
            
            
            wallPiece.isAlive = false
            wallPiece.removeFromParent()
        }
        if(gridY < maxRows - 1 && wallArray[gridY + 1][gridX].isAlive) {
            let N = wallArray[gridY + 1][gridX]
            let newWallTop = WallTop(size: wallPiece.size, position: N.position)
            wallHelper(newWallPiece: newWallTop, gridX: gridX, gridY: gridY)
            wallArray[gridY + 1][gridX] = newWallTop
            
            N.isAlive = false
            N.removeFromParent()
        }
        
    }
    
    func removeAWall(gridX: Int, gridY: Int){
        let wallPiece = wallArray[gridY][gridX]
        
        let newWall = Wall()

        newWall.position = wallPiece.position

        newWall.size.width = wallPiece.size.width
        newWall.size.height = wallPiece.size.height
        newWall.isAlive = false
        
        self.addChild(newWall)
        
        wallArray[gridY][gridX] = newWall
        
        wallPiece.isAlive = false
        wallPiece.removeFromParent()
        
        if(gridY < maxRows - 1 && wallArray[gridY + 1][gridX].isAlive) {
            let N = wallArray[gridY + 1][gridX]
            let newIsoWall = IsometricMazeWall(size: N.size, position: N.position)
            wallHelper(newWallPiece: newIsoWall, gridX: gridX, gridY: gridY)
            wallArray[gridY + 1][gridX] = newIsoWall
            
            N.isAlive = false
            N.removeFromParent()
        }
    }
    
    
    func generateGrid(rows: Int, columns: Int, width: Int, yOffset: CGFloat) {
        let  rowsForSize = 5
        
        tileWidth = CGFloat(width/rowsForSize)
        tileHeight = tileWidth

        backroundTileWidth = tileWidth * 2
        backroundTileHeight = tileWidth * 2
        
        self.addChild(gridLayer)

        
        for row in 0 ..< rows {
            
            /* Initialize empty column */
            gridArray.append([])
            wallArray.append([])
            if ( row % 2 == 0 ) { floorTileArray.append([]) }
            
            for col in 0 ..< columns {
                /* Create a new creature at row / column position */
                addGridObjectAtGrid(row: row, col: col, yOffset: yOffset)
                addWallAtGrid(row: row, col: col, yOffset: yOffset)
                if( (row % 2 == 0) && (col % 2 == 0)) { addFloorObjectAtGrid(row: row, col: col, yOffset: yOffset) }
            }
        }
        gridYSize = tileHeight * CGFloat( rows ) + yOffset
        gridXSize = tileWidth * CGFloat( columns )
        maxRows = rows
        maxCols = columns
    }
    
    
    func addGridObjectAtGrid(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        
        /* New gridPiece object */
        let gridObject = GridPiece()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
        
       
        
        gridObject.size.width = CGFloat(tileWidth)
        gridObject.size.height = CGFloat(tileHeight)
        
        
        gridObject.position = gridPosition
        
        /* Set default isAlive */
        
        /* Add gridPiece to grid node */
        gridLayer.addChild(gridObject)
        
        /* Add gridPiece to grid array */
        gridArray[row].append(gridObject)
    }
    
    /* add the IsometricWall Pieces to the grid */
    
    func addWallAtGrid(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        
        /* New gridPiece object */
        let wallObject = Wall()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
        
        wallObject.size.width = CGFloat(tileWidth)
        wallObject.size.height = CGFloat(tileHeight)
        
        wallObject.position = gridPosition
        
        /* Set default creature to dead */
        wallObject.isAlive = false
        
        /* Add gridPiece to grid node */
        addChild(wallObject)
        
        /* Add gridPiece to grid array */
        wallArray[row].append(wallObject)
    }
    
    func addFloorObjectAtGrid(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        
        /* New gridPiece object */
        let floorObject = FloorTiles()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
        
        floorObject.size.width = CGFloat(backroundTileWidth)
        floorObject.size.height = CGFloat(backroundTileHeight)
        
        floorObject.position = gridPosition
        
        /* Add gridPiece to grid node */
        addChild(floorObject)
        
        /* Add gridPiece to grid array */
        floorTileArray[row/5].append(floorObject)
    }
    
    
    
    
    
}
