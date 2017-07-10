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
    
    let gridPieceObject = GridPiece()
    
    let BuildingAMaze = GridPiece().size.height
    
    var tileWidth: CGFloat = 0
    var tileHeight: CGFloat = 0
    
    
    
    func generateGrid(rows: Int, columns: Int, width: Int) {
        let  rowsForSize = 5
        
        tileWidth = CGFloat(width/rowsForSize)
        tileHeight = tileWidth
        
        let numRows = rows
        let numColumns = columns
        
        gridPieceObject.size.width = CGFloat(tileWidth)
        gridPieceObject.size.height = CGFloat(tileHeight)
        
        for row in 0 ... numRows {
            
            /* Initialize empty column */
            gridArray.append([])
            
            for col in 0 ... numColumns {
                /* Create a new creature at row / column position */
                addGridObjectAtGrid(row: row, col: col)
            }
        }
    }
    
    
    func tilePosition(row:Int, col:Int) -> CGPoint {
        let x = (CGFloat(row) * tileWidth) + (tileWidth  / 2.0)
        let y = (CGFloat(col) * tileHeight) + (tileHeight / 2.0)
        return CGPoint(x: x, y: y)
    }
    


    func addGridObjectAtGrid(row: Int, col: Int) {
        /* Add a new creature at grid position*/
        
        /* New creature object */
        let gridObject = GridPiece()
        /* Calculate position on screen */
        let gridPosition = CGPoint(x: (CGFloat(row) * tileWidth) + (tileWidth  / 2.0), y: (CGFloat(col) * tileHeight) + (tileHeight / 2.0))
        
        gridObject.position = gridPosition
        
        /* Set default isAlive */
        
        /* Add creature to grid node */
        addChild(gridObject)
        
        /* Add creature to grid array */
        gridArray[row].append(gridObject)
    }

    
}
