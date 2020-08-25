//
//  RandomColorGenerator.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

// For Cell Coloration
enum CellColors: Int {
    case orange
    case pink
    case green
    case blue
    case yellow
    case black
    case random
}

extension UIColor {

    func setRandomColor() -> UIColor {
        let randomColorNum = Int.random(in: 1...5)
        
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

class ColorHelper {
    static let shared = ColorHelper()
    
    var cellColor: CellColors = .black {
        didSet {
            NotificationCenter.default.post(name: .cellChangesColor, object: nil)
        }
    }
}
