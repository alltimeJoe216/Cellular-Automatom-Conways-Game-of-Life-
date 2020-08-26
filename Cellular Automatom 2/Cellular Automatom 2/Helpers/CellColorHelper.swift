//
//  File.swift
//  Cellular Automatom 2
//
//  Created by Joseph Veverka on 8/26/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class CellColorHelper {
    // Singleton
    static let shared = CellColorHelper()
    
    var cellColorIndex: Int = 0
    
    // Get cell color by index
    var cellColor : UIColor {
        get {
            return self.colors[cellColorIndex]
        }
    }
    
    let colors = [
        UIColor.systemPink,
        UIColor.systemGray,
        UIColor.systemBlue,
        UIColor.systemTeal,
        UIColor.systemIndigo,
        UIColor.systemGreen,
        UIColor.systemOrange,
        UIColor.systemPurple,
        UIColor.systemYellow,
        UIColor.systemRed,
        UIColor.label
    ]
    
    private init() {
        
    }
}
