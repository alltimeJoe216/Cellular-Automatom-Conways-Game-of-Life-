//
//  PresetCVCell.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/25/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class PresetCell: UITableViewCell {
    
    static var identifier: String = "PresetCell"
    
    var preset: ShapePreset!
    var label = UILabel()
    
    func set(preset: ShapePreset ) {

        translatesAutoresizingMaskIntoConstraints = false
        self.preset = preset
        label.text = preset.currentPreset.rawValue.capitalized
        label.translatesAutoresizingMaskIntoConstraints = false
        preset.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    override func layoutSubviews() {

        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.40)
        layer.backgroundColor = UIColor.clear.cgColor
    }

    
}
