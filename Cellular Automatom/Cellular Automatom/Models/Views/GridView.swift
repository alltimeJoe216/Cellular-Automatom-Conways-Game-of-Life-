//
//  GridView.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

/*
 
 USER Functions/Property ideas:
 
 Will need games funcs like run, reset grid, presets(tap for single cell? block? random? beacon, gliders?) <-- if time allows it
 
 
 
 GRID Functions/properties:
 
 Will need one grid basically sitting on top of another one...
 Dimensions for grid (width, height..cell size?)
 Generations must be noted somewhere on VC... (didSet??)
 
 Want to be able to speed up and slow down the game...not sure how this can be implemented yet
 
 */

class GridView {
    
    //MARK: - Grid Properties
    
    // Grid
    var gridView: UIView!
    // Grid size
    var gridWidth: CGFloat!
    var gridHeight: CGFloat!
    
    
    // Cell size
    var cellDims: CGFloat!
    // Array of array of cells to populate grid
    var bottomGrid = [[CellView]]()
    var topGrid = [[CellView]]()
    
    //MARK: - View Inits
    init(gridWidth: CGFloat, gridHeight: CGFloat, gridView: UIView) {
        
        self.gridView = gridView
        self.gridHeight = gridHeight
        self.gridWidth = gridWidth
        self.cellDims = gridWidth / 50 // 50x50 grid?
        
    }
    
    //MARK: - Grid(Game) FUnctions
    
    func resetGame() {
        
    }
    
    func resetGrid(grid: [[CellView]]) {
        
    }
    
    func countCellNeighbors(for cellX: Int, for cellY: Int) -> Int {
        
        // how many neighbs babe
        var neighborCount = 0
        
        // need row count for algo
        let rowCount = 50
        
        // Horizontal check (check one cell to the left, and one cell to the right)
        for i in cellX-1...cellX+1 {
            
            
            // Vertical check (check one cell above and one below)
            for j in cellY-1...cellY+1 {
                
                
                if (i == cellX && j == cellY) || (i >= rowCount) || (j >= rowCount) || ( i < 0 ) || (j < 0) {
                    
                    continue
                }
                
                if bottomGrid[i][j].isAlive { neighborCount += 1}
            }
        }
        return neighborCount
    }
    
    func draw() {
        
        for cellX in 0...49 {
            
            for cellY in 0...49 {
                
                topGrid[cellX][cellY].isAlive ?
                    
                    bottomGrid[cellX][cellY].birthACell() :
                    bottomGrid[cellX][cellY].murderCell()
            }
        }

    }
    
    func nextCell() {
        
    }
}



