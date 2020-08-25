//
//  CellPresets.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/25/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit


class ShapePreset: UIView {

    //MARK: - Class Properties
    var starterPreset: CellPresets = .singleCell
    var cellWidth: CGFloat
    var box = [[CellView]]()
    var size: Int
    
    //MARK: -Init
    init( size: Int,
          cellWidth: CGFloat,
          presetStyle: CellPresets)
    {
        
        self.size = size
        self.starterPreset = presetStyle
        self.cellWidth = cellWidth
        super.init(frame: CGRect(x: 0, y: 0, width: Int(cellWidth) * size, height: Int(cellWidth) * size))
        self.backgroundColor = .white
        box = setupPresetGrid()
        initPresets()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPresetGrid() -> [[CellView]] {
        
        var grid = [[CellView]]()
        
        var gridColumn = [CellView]()
        
        for j in 0...(size - 1) {
            
            for i in 0...(size - 1) {
                
                let cell = CellView(frame: CGRect(x: cellWidth * CGFloat(j), y: cellWidth * CGFloat(i), width: cellWidth, height: cellWidth))

                cell.isUserInteractionEnabled = false
                addSubview(cell)
                
                gridColumn.append(cell)
            }
            grid.append(gridColumn)
            gridColumn.removeAll()
        }
        return grid
    }
    
    func initPresets() {
        // this will be the preset that loads when first launching
        if starterPreset == .singleCell {
            
            box[0][0].birthACell()
            
        }
        
        switch starterPreset {

            //drawing presets
        case .singleCell:
            box[0][0].birthACell()

        case .glider:
            box[1][0].birthACell()
            box[2][1].birthACell()
            box[0][2].birthACell()
            box[1][2].birthACell()
            box[2][2].birthACell()
        case .block:
            box[0][0].birthACell()
            box[0][1].birthACell()
            box[1][0].birthACell()
            box[1][1].birthACell()
        case .random:
            print("random")
        }
        
    }
}

// Used above
enum CellPresets: String {
    case singleCell
    case block
    case glider
    case random
}
