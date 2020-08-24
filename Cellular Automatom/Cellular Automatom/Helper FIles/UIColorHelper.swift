//
//  RandomColorGenerator.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

// For Cell Coloration

extension UIColor {

    func setRandomColor() -> UIColor {
        let randomColorNum = Int.random(in: 1...4)
        
        switch randomColorNum {
        case 1:
            return UIColor.orange
        case 2:
            return UIColor.systemPink
        case 3:
            return UIColor.green
        case 4:
            return UIColor.blue
        case 5:
            return UIColor.yellow
        default:
            return UIColor.black
        }
    }
}
