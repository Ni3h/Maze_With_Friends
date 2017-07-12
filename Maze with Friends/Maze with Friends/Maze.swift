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
    var isometricWallArray = [[IsometricMazeWall]]()
    var wallTopArray = [[WallTop]]()
    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    var gridXSize: CGFloat = 0
    var gridYSize: CGFloat = 0
    
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
    
    
    func generateGrid(rows: Int, columns: Int, width: Int, yOffset: CGFloat) {
        let  rowsForSize = 5
        
        tileWidth = CGFloat(width/rowsForSize)
        tileHeight = tileWidth
        
        backroundTileWidth = tileWidth * 5
        backroundTileHeight = tileWidth * 5
        
        for row in 0 ..< rows {
            
            /* Initialize empty column */
            gridArray.append([])
            wallArray.append([])
            if ( row % 5 == 0 ) { floorTileArray.append([]) }
            
            for col in 0 ..< columns {
                /* Create a new creature at row / column position */
                addGridObjectAtGrid(row: row, col: col, yOffset: yOffset)
                addWallAtGrid(row: row, col: col, yOffset: yOffset)
                if( (row % 5 == 0) && (col % 5 == 0)) { addFloorObjectAtGrid(row: row, col: col, yOffset: yOffset) }
            }
        }
        gridYSize = tileHeight * CGFloat( rows ) + yOffset
        gridXSize = tileWidth * CGFloat( columns )
        
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
        addChild(gridObject)
        
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
    
//    func addIsometricMazeWallAtGrid(row: Int, col: Int, yOffset: CGFloat) {
//        /* Add a new gridPiece at grid position*/
//        
//        /* New gridPiece object */
//        let isoMetricWallObject = IsometricMazeWall()
//        
//        /* Calculate position on screen */
//        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
//        
//        isoMetricWallObject.size.width = CGFloat(tileWidth)
//        isoMetricWallObject.size.height = CGFloat(tileHeight)
//        
//        isoMetricWallObject.position = gridPosition
//        
//        /* Set default creature to dead */
//        isoMetricWallObject.isAlive = false
//        
//        /* Add gridPiece to grid node */
//        addChild(isoMetricWallObject)
//        
//        /* Add gridPiece to grid array */
//        isometricWallArray[row].append(isoMetricWallObject)
//    }
//
//    /* add the WallTop to the grid */
//    func addWallTopAtGrid(row: Int, col: Int, yOffset: CGFloat) {
//        /* Add a new gridPiece at grid position*/
//        
//        /* New gridPiece object */
//        let wallTopObject = WallTop()
//        
//        /* Calculate position on screen */
//        let gridPosition = CGPoint(x: (CGFloat(col) * tileWidth) , y: ((CGFloat(row) * tileHeight) + yOffset))
//        
//        wallTopObject.size.width = CGFloat(tileWidth)
//        wallTopObject.size.height = CGFloat(tileHeight)
//        
//        wallTopObject.position = gridPosition
//        
//        /* Set default creature to dead */
//        wallTopObject.isAlive = false
//        
//        /* Add gridPiece to grid node */
//        addChild(wallTopObject)
//        
//        /* Add gridPiece to grid array */
//        wallTopArray[row].append(wallTopObject)
//    }
//    
    
    
    
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
