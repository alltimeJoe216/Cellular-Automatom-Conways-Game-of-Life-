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
    
    // Timer for speed
    var timer = Timer()
    
    
    // Cell size
    var cellDims: CGFloat!
    // Array of array of cells to populate grid
    var bottomGrid = [[CellView]]()
    var topGrid = [[CellView]]()
    var currentPreset: ShapePreset!
    var presets: [ShapePreset] = []
    
    //MARK: - Computed Properties ( Generation + Speed )
    
    var generations = 0 {
        
        didSet{
            
            NotificationCenter.default.post(name: .generationChanged, object: nil, userInfo: ["generations": generations])
        }
        
    }
    
    var speed: Float = 0.2 {
        
        didSet{
            
            if timer.isValid {
                
                speedChanged()
            }
        }
    }
    
    //MARK: - View Inits
    init(gridWidth: CGFloat, gridHeight: CGFloat, gridView: UIView) {
        
        self.gridView = gridView
        self.gridHeight = gridHeight
        self.gridWidth = gridWidth
        self.cellDims = gridWidth / 50 // 50x50 grid?
        
    }
    
    //MARK: - Grid(Game) FUnctions
    
    func run() {
        nextCell()
        generations += 1
        
    }
    
    func setupGrid(width: CGFloat, height: CGFloat, view: UIView, isNext: Bool = false) -> [[CellView]] {
        
        var grid = [[CellView]]()
        var gridColumn = [CellView]()
        for j in 0...24 {
            for i in 0...24 {
                
                let cell = CellView(frame: CGRect(x: width / 25 * CGFloat(j), y: height / 2 - width / 2 + width / 25 * CGFloat(i), width: width / 25, height: width / 25), isAlive: false)
                cell.gridView = self
                if !isNext { view.addSubview(cell) }
                gridColumn.append(cell)
            }
            grid.append(gridColumn)
            gridColumn.removeAll()
        }
        return grid
    }
    
    func resetGame() {
        
        // re-enable Interaction
        gridView.isUserInteractionEnabled = true
        
        //reset timer
        timer.invalidate()
        
        // reset grid
        resetGrid(grid: bottomGrid)
        
        // reset gens
        generations = 0
    }
    
    func resetGrid(grid: [[CellView]]) {
        
        // *** KILL THEM ALL ***
        for x in 0...49 {
            
            for y in 0...49 {
                
                grid[x][y].murderCell() // 🤟🏼
                
            }
        }
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
        resetGrid(grid: topGrid)
        
        // Iterating through each cell on X-axis
        for x in 0...49 {
            // then Y-Axis
            for y in 0...49 {
                
                //Cell is alive
                let cellState = bottomGrid[x][y].isAlive
                let neighbors = countCellNeighbors(for: x, for: y)
                
                // If cell is alive
                if cellState == true {
                    
                    
                    if neighbors == 2 || neighbors == 3 {
                        
                        topGrid[x][y].birthACell()
                        
                    } else {
                        
                        topGrid[x][y].murderCell()
                    }
                    
                } else {
                    
                    if neighbors == 3 {
                        
                        topGrid[x][y].birthACell()
                    }
                }
            }
        }
        
        draw()
    }
    
    //MARK: - Timer and SPeed related methods
    
    func configureTimer() {
        
        //Check to see if timer is validated
        if timer.isValid {
            timer.invalidate()
            gridView.isUserInteractionEnabled = true
            
        } else {
            gridView.isUserInteractionEnabled = false
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(speed), repeats: true, block: { (timer) in
                self.run()
            })
        }
    }
    
    func speedChanged() {
        
        //Always invalidate
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(speed), repeats: true, block: { (timer) in
            
            // Run it
            self.run()
            
        })
    }
}



