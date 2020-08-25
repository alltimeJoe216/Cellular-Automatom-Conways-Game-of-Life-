//
//  Cell.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

/*
 # Things we'll need/Things I want
 
 */

class CellView: UIView {
    
    //MARK: - Properties
    
    var isAlive : Bool = false
    var gridView : GridView?
    
    //MARK: - COmputed Properties
    
    // Cell Color Changes
    var cellColor : UIColor{
        
        switch ColorHelper.shared.cellColor {
            
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .pink:
            return .systemPink
        case .black:
            return .black
        case .yellow:
            return .yellow
        case .random:
            return UIColor().setRandomColor()
        case .orange:
            return .orange
        }
    }
    
    //MARK: - View inits
    
    // notification center/observers?
    
    // For cell view initialization
    init(frame: CGRect, isAlive: Bool = false) {
       super.init(frame: frame)
        
        self.isAlive = isAlive // Set to false to start in init...don't want to open the game to cells already present
        
        // Cell
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(colorChanged), name: .cellChangesColor, object: nil)

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
        self.isAlive = false
        self.backgroundColor = .white
        
    }
    
    func birthACell() {
        self.isAlive = true
        self.backgroundColor = cellColor
        
    }
    
    @objc func colorChanged() {
           if isAlive { backgroundColor = cellColor }
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
           guard let preset = gridView?.currentPreset else { return }
           guard let coordinates = returnCoords() else { return }
           if preset.box.count == 1 {
               if isAlive == false {
                   birthACell()
               } else {
                   murderCell()
               }
           } else if ((preset.box.count * preset.box.count) / 2) == 2 {
               checkFor4(coordinates: coordinates)
           } else if ((preset.box.count * preset.box.count) / 2) == 4 {
               checkFor9(coordinates: coordinates)
           } else if ((preset.box.count * preset.box.count) / 2) == 8 {
               checkFor16(coordinates: coordinates)
           }
       }
       
       func checkFor4(coordinates: (x: Int, y: Int)) {
           let rows = 50

           for i in coordinates.x...coordinates.x+1 {
               for j in coordinates.y...coordinates.y+1 {
                   if ((i >= rows) || (j >= rows) || ( i < 0 ) || (j < 0)) {
                       continue
                   }
                   guard let presetCellIsActive = gridView?.currentPreset.box[i - coordinates.x ][j - coordinates.y].isAlive else { return }
                   if presetCellIsActive {
                       gridView?.bottomGrid[i][j].birthACell()
                   } else {
                       gridView?.bottomGrid[i][j].birthACell()
                   }
               }
           }
       }
       
       func checkFor16(coordinates: (x: Int, y: Int)) {
           let rows = 50
           
           for i in coordinates.x-1...coordinates.x+2 {
               for j in coordinates.y-1...coordinates.y+2 {
                   if ((i >= rows) || (j >= rows) || ( i < 0 ) || (j < 0)) {
                       continue
                   }
                   guard let presetCellIsActive = gridView?.currentPreset.box[i - coordinates.x + 1][j - coordinates.y + 1].isAlive else { return }
                   if presetCellIsActive {
                       gridView?.bottomGrid[i][j].birthACell()
                   } else {
                       gridView?.bottomGrid[i][j].murderCell()
                    
                   }
               }
           }
       }
       
       func checkFor9(coordinates: (x: Int, y: Int)) {
           let rows = 25
           
           for i in coordinates.x-1...coordinates.x+1 {
               for j in coordinates.y-1...coordinates.y+1 {
                   if ((i >= rows) || (j >= rows) || ( i < 0 ) || (j < 0)) {
                       continue
                   }
                   
                   guard let presetCellIsActive = gridView?.currentPreset.box[i - coordinates.x + 1][j - coordinates.y + 1].isAlive else { return }
                   if presetCellIsActive {
                       gridView?.bottomGrid[i][j].birthACell()
                   } else {
                       gridView?.bottomGrid[i][j].murderCell()
                   }
               }
           }
       }
}
