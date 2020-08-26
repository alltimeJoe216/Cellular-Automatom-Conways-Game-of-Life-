//
//  PresetTableViewCell.swift
//  Cellular Automatom 2
//
//  Created by Joseph Veverka on 8/26/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView:UIView!
    @IBOutlet weak var colorFrameView:UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.colorView.layer.cornerRadius = self.colorView.frame.size.width / 2
        self.colorView.clipsToBounds = true
        self.colorView.layer.masksToBounds = false
        
        self.colorFrameView.layer.cornerRadius = self.colorFrameView.frame.size.width / 2
        self.colorFrameView.clipsToBounds = true
        self.colorFrameView.layer.masksToBounds = false
        self.colorFrameView.backgroundColor = UIColor.systemBackground

        self.contentView.layer.cornerRadius = self.frame.size.width / 2
        self.contentView.clipsToBounds = true
        self.contentView.layer.masksToBounds = false

    }
    
}

