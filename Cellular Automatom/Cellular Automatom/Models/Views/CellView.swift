//
//  Cell.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    //MARK: - Properties
    
    var isAlive: Bool = false
    
    //MARK: Class Functions
    
    func configureCell() {
        
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
