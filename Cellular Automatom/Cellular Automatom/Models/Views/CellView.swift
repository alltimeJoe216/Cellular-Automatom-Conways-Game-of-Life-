//
//  Cell.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

/*
 # Things we'll need/Things I want:
 
    -GridView (class)
    -Is the
 
 */

class CellView: UIView {
    
    //MARK: - Properties
    
    var isAlive: Bool = false
    var gridView: GridView?
    
    //MARK: - View inits
    
    // notification center/observers?
    
    // For cell view initialization
    init(frame: CGRect, isAlive: Bool = false) {
       super.init(frame: frame)
        
        self.isAlive = isAlive // Set to false to start in init...don't want to open the game to cells already present
        
        // Cell
        setUpViews()
        
        
        
        
        
    
    }
    
    // Blah blah, what do you even do? (jk)
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
    }
    
    
    
    //MARK: Class Functions
    
    func setUpViews() {
        
        self.backgroundColor = UIColor(white: 10, alpha: 0.5)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.5
        
    }
    
    func returnCoords() -> (x: Int, y: Int)? {
        
        let x = 1
        let y = 2
        let z = (x, y)
        
        return z
    }
    
    func murderCell() {
        
    }
    
    func birthACell() {
        
    }
    
     
    
    
}
