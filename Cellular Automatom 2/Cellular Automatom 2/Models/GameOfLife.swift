//
//  GameOfLife.swift
//  Cellular Automatom 2
//
//  Created by Joseph Veverka on 8/26/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class GameOfLife {
    
    //MARK: - Class Properties
    
    // Singleton Class
    static let shared = GameOfLife()
    
    // Game properties
    internal let columns = 25
    internal let rows = 25
    var cellStatus = [[Bool]]()
    
    
    //MARK: Init
    private init() {
        
        randomize()
    }
    
    //MARK: - Game Functions
    
    // Set cell state randomly
    
    public func randomize() {
        
        cellStatus = [[Bool]]()
        
        for _ in 0 ..< rows {
            
            var rows = [Bool]()
            
            for _ in 0 ..< columns {
                
                let val = Int.random(in: 0..<1000) // set random value
                
                rows.append(val % 2 == 0)
            }
            // add cells to rows
            cellStatus.append(rows)
        }
    }
    
    // Set cell state false
    
    public func clear() {
        cellStatus = [[Bool]]()
        for _ in 0 ..< rows {
            var rows = [Bool]()
            for _ in 0 ..< columns {
                rows.append(false)
            }
            cellStatus.append(rows)
        }
    }
    
    // Check status of all cells
    public func checkLife() -> Int  {
        var newStatus = [[Bool]]()
        var count:Int = 0
        for row in 0 ..< rows {
            var rows = [Bool]()
            for column  in 0 ..< columns {
                let status = checkCell(point:CGPoint(x: column, y: row))
                rows.append(status)
                if status {
                    count += 1
                }
            }
            newStatus.append(rows)
        }
        self.cellStatus = newStatus
        return count
    }
    
    public func setStatus(index:Int, status:Bool) {
        let x = index % GameOfLife.shared.columns
        let y = index / GameOfLife.shared.columns
        self.cellStatus[y][x] = status
    }
    
    public func setStatus(point: CGPoint, status:Bool) {
        let x = Int(point.x)
        let y = Int(point.y)
        self.cellStatus[y][x] = status
    }
    
    public func getStatus(index: Int) -> Bool {
        let x = index % GameOfLife.shared.columns
        let y = index / GameOfLife.shared.columns
        return self.cellStatus[y][x]
    }
    
    public func setOscillator(oscillator: Pattern, at: CGPoint) {
        oscillator.cells.forEach {
            let point = $0
            self.setStatus(point: CGPoint(x: at.x + point.x, y: at.y + point.y), status: true)
        }
    }
    
    public func setOscillator(oscillator: Pattern) {
        let width = Int(oscillator.size.width)
        let height = Int(oscillator.size.height)
        
        let x = self.columns / 2 - width / 2
        let y = self.rows / 2 - height / 2
        self.setOscillator(oscillator: oscillator, at: CGPoint(x: x, y: y))
    }
    
    // Count living cells around
    internal func countNeighbors(x:Int, y:Int) -> Int {
        
        let points = [
            CGPoint(x: x - 1 , y: y - 1),
            CGPoint(x: x - 1 , y: y),
            CGPoint(x: x - 1 , y: y + 1),
            
            CGPoint(x: x , y: y - 1),
            CGPoint(x: x , y: y + 1),
            
            CGPoint(x: x + 1 , y: y - 1),
            CGPoint(x: x + 1 , y: y),
            CGPoint(x: x + 1 , y: y + 1),
        ]
        
        var count:Int = 0
        
        points.forEach {
            let point = $0
            var x = Int(point.x)
            var y = Int(point.y)
            
            if x < 0 {
                x = columns - 1
            }
            else if x == columns {
                x = 0
            }
            
            if y < 0 {
                y = rows - 1
            }
            else if y == rows {
                y = 0
            }
            count += cellStatus[y][x] ? 1 : 0
        }
        return count
    }
    
    // Check state of cell
    internal func checkCell(point: CGPoint) -> Bool {
        
        let x = Int(point.x)
        let y = Int(point.y)
        
        let count = countNeighbors(x: x, y: y)
        
        if !cellStatus[y][x]  {
            if count == 3 {
                //change to live
                return true
            }
            else {
                //under population
                return false
            }
        }
        else {
            if count == 2 || count == 3 {
                //lives on to the next generation
                return true
            }
            else {
                //over population or under population
                return false
            }
        }
    }
}


