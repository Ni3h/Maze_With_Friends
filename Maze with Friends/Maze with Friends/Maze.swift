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
    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    var gridXSize: CGFloat = 0
    var gridYSize: CGFloat = 0
    
    var backroundTileWidth: CGFloat = 0
    var backroundTileHeight: CGFloat = 0
    
    
    
    func mazeDimensions() -> (x: CGFloat, y: CGFloat) {
        let x = gridXSize
        let y = gridYSize
        return (x, y)
    }
    
    
    func generateGrid(rows: Int, columns: Int, width: Int, yOffset: CGFloat) {
        let  rowsForSize = 5
        
        tileWidth = CGFloat(width/rowsForSize)
        tileHeight = tileWidth
        
        backroundTileWidth = tileWidth * 5
        backroundTileHeight = tileWidth * 5
        
        for row in 0 ... rows {
            
            /* Initialize empty column */
            gridArray.append([])
            if (row % 5 == 0) { floorTileArray.append([]) }
            
            for col in 0 ... columns {
                /* Create a new creature at row / column position */
                addGridObjectAtGrid(row: row, col: col, yOffset: yOffset)
                if( col % 5 == 0) { addFloorObjectAtGrid(row: row, col: col, yOffset: yOffset) }
            }
        }
        gridYSize = tileHeight * CGFloat(rows)
        gridXSize = tileWidth * CGFloat(columns)
        
    }


    func addGridObjectAtGrid(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        
        /* New gridPiece object */
        let gridObject = GridPiece()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(row) * tileWidth) , y: ((CGFloat(col) * tileHeight) + yOffset))

        gridObject.size.width = CGFloat(tileWidth)
        gridObject.size.height = CGFloat(tileHeight)

        
        gridObject.position = gridPosition
        
        /* Set default isAlive */
        
        /* Add gridPiece to grid node */
        addChild(gridObject)
        
        /* Add gridPiece to grid array */
        gridArray[row].append(gridObject)
    }
    
    func addFloorObjectAtGrid(row: Int, col: Int, yOffset: CGFloat) {
        /* Add a new gridPiece at grid position*/
        
        /* New gridPiece object */
        let floorObject = FloorTiles()
        
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(row) * backroundTileWidth) , y: ((CGFloat(col) * backroundTileHeight) + yOffset))
        
        floorObject.size.width = CGFloat(backroundTileWidth)
        floorObject.size.height = CGFloat(backroundTileHeight)
        
        
        floorObject.position = gridPosition
        
        /* Set default isAlive */
        
        /* Add gridPiece to grid node */
        addChild(floorObject)
        
        /* Add gridPiece to grid array */
        floorTileArray[row/5].append(floorObject)
    }
    
    
    

    
}
